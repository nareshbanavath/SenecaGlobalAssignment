//
//  UsersViewController.swift
//  SenecaGlobalAssignment
//
//  Created by naresh banavath on 30/04/21.
//

import UIKit

class UsersViewController: UIViewController {
 
  @IBOutlet weak var tableView: UITableView!
  var tableViewDataSource : [UserModel]?
  override func viewDidLoad() {
        super.viewDidLoad()
        getUserData()
    tableView.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }
   //MARK:- get user data service call
  func getUserData()
  {
    self.showActivityIndicater()
    let endUrl = "https://reqres.in/api/users?page=1"
    guard let url = URL(string: endUrl) else {return}
    var urlRequest = URLRequest(url: url)
    urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
    NetworkRequest.makeRequest(type: UsersModel.self, urlRequest: urlRequest) { [weak self](result) in
      self?.hideActivityIndicator()
      switch result
      {
      case.success(let usersData):
        self?.tableViewDataSource = usersData.users
        DispatchQueue.main.async {
          self?.tableView.reloadData()
        }
        
      case .failure(let err):
        print(err.localizedDescription)
      }
    }
  }
  
}

extension UsersViewController : UITableViewDataSource
{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tableViewDataSource?.count ?? 0
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "UsersTBCell") as! UsersTBCell
    cell.configureCell(user: tableViewDataSource?[indexPath.row])
    return cell
  }
}
