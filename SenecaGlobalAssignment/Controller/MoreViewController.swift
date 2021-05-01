//
//  MoreViewController.swift
//  SenecaGlobalAssignment
//
//  Created by naresh banavath on 30/04/21.
//

import UIKit
import CoreData
class MoreViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  {
    didSet
    {
      tableView.dataSource = self
    }
  }
  var tableViewDataSource : [MoreStructElement]?
  let entityArray = [ "User" , "Company" , "Geo" ,"Address" ]
  override func viewDidLoad() {
        super.viewDidLoad()
    tableView.tableFooterView = UIView()
    tableView.separatorColor = .clear
    
    getDataFromLocalStorage()
        // Do any additional setup after loading the view.
    }
   func getCompanyData()
   {
    self.showActivityIndicater()
    
    let endUrl = "https://jsonplaceholder.typicode.com/users"
    guard let url = URL(string: endUrl) else {return}
    var urlRequest = URLRequest(url: url)
    urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
    NetworkRequest.makeRequestArray(type: MoreStructElement.self, urlRequest: urlRequest) { [weak self](result) in
      self?.hideActivityIndicator()
      switch result
      {
      case.success(let usersData):
        self?.tableViewDataSource = usersData
        //print(usersData)
        self?.saveDataToCoreData()
        DispatchQueue.main.async {
          self?.tableView.reloadData()
        }
        
      case .failure(let err):
        print(err.localizedDescription)
      }
    }
   }
   func saveDataToCoreData()
   {
    guard let users = tableViewDataSource else {return}
    for usr in users
    {
      CoreDataManager.manager.createStructToCDUser(user: usr)
      //CoreDataManager.manager.saveContext()
      
    }
    CoreDataManager.manager.saveContext()
    CoreDataManager.manager.getDirectoryUrl()

    
   }
//  func clearData()
//  {
//
//    for entity in entityArray{
//
//      let fetchRequest : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entity)
//      let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
//      do{
//        try CoreDataManager.manager.persistentContainer.viewContext.execute(deleteRequest)
//      }catch {
//        print(error.localizedDescription)
//      }
//    }
//  }
  func getDataFromLocalStorage()
  {
    guard let users = CoreDataManager.manager.getAllData() else {getCompanyData();return}
    tableViewDataSource = users
    tableView.reloadData()
  }

}
extension MoreViewController : UITableViewDataSource
{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tableViewDataSource?.count ?? 0
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "MoreTBCell") as! MoreTBCell
    cell.configure(user : tableViewDataSource?[indexPath.row])
    return cell
  }
}
