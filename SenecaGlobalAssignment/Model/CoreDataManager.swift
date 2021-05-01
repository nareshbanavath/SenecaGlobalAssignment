//
//  CoreDataManager.swift
//  SenecaGlobalAssignment
//
//  Created by naresh banavath on 30/04/21.
//

import Foundation
import CoreData
public class CoreDataManager
{
    static let manager = CoreDataManager()
    private init(){}//to re

    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "SenecaGlobalAssignment")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
  func fetchManagedObject<T: NSManagedObject>(managedObject: T.Type , predicate : NSPredicate? = nil) -> [T]?
  {
    let entityName = String(describing: T.self)
    let fetchRequest = NSFetchRequest<T>(entityName: entityName)
  //  let fetchRequest = managedObject.fetchRequest()
    fetchRequest.predicate = predicate
      do {
        guard let result = try CoreDataManager.manager.persistentContainer.viewContext.fetch(fetchRequest) as? [T] else {return nil}

          return result

      } catch let error {
          debugPrint(error)
      }

      return nil
  }
  func getDirectoryUrl()
  {
    print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
  }
  func createStructToCDUser(user : MoreStructElement)
  {
    let context = CoreDataManager.manager.persistentContainer.viewContext
    let coreUser = User(context: context)
    coreUser.name = user.name
    coreUser.email = user.email
    coreUser.phone = user.phone
    coreUser.id = Int64(user.id ?? 0)
    coreUser.username = user.username
    coreUser.website = user.website
    
    let coreAddress = Address(context: context)
    coreAddress.street = user.address?.street
    coreAddress.suit = user.address?.suite
    coreAddress.zipcode = user.address?.zipcode
    coreAddress.city = user.address?.city
    coreAddress.parentUser = coreUser
    //coreUser.address = coreAddress
    
    let coreGeo = Geo(context: context)
    coreGeo.lat = user.address?.geo?.lat
    coreGeo.long = user.address?.geo?.lng
    coreGeo.parentAddress = coreAddress
    //coreUser.address?.geo = coreGeo
    
    let coreCompany = Company(context: context)
    coreCompany.bs = user.company?.bs
    coreCompany.catchPhrase = user.company?.catchPhrase
    coreCompany.name = user.company?.name
    coreCompany.parentUser = coreUser
    //coreUser.company = coreCompany
    
  }
  func getAllData() -> [MoreStructElement]?
  {
    var usersArray : [MoreStructElement] = []
    guard let users = self.fetchManagedObject(managedObject: User.self) else {return nil}
   // users.forEach({print($0.name)})
    guard users.count != 0 else {return nil}
    for usr in users
    {
      var userStruct = usr.toStruct()
      let predicate = NSPredicate(format: "parentUser.id MATCHES %@",String(usr.id))
      let addressResult = fetchManagedObject(managedObject: Address.self , predicate: predicate)
      if let addr = addressResult?.first
      {
        userStruct.address = addr.toStruct()
        let predicate = NSPredicate(format: "parentAddress.city == %@",addr.city!)
        let Coregeo = fetchManagedObject(managedObject: Geo.self , predicate: predicate)
        if let geo = Coregeo?.first {
          userStruct.address?.geo = geo.toStruct()
        }
      }
      let companyResult = fetchManagedObject(managedObject: Company.self , predicate: predicate)
      if let company = companyResult?.first
      {
        userStruct.company = company.toStruct()
      }
      
      usersArray.append(userStruct)
    }
    return usersArray.count == 0 ? nil : usersArray
    
  }
}
extension User
{
  func toStruct() -> MoreStructElement
  {
    return MoreStructElement(id: Int(self.id), name: self.name, username: self.username, email: self.email, address: nil, phone: self.phone, website: self.website, company: nil)
  }
}
extension Address{
  func toStruct() -> AddressStruct
  {
    return AddressStruct(street: self.street ?? "", suite: self.suit ?? "", city: self.city ?? "", zipcode: self.zipcode ?? "", geo: nil)
  }
}
extension Company{
  func toStruct() -> CompanyStruct {
    return CompanyStruct(name: self.name ?? "", catchPhrase: self.catchPhrase ?? "", bs: self.bs ?? "")
  }
}
extension Geo
{
  func toStruct() -> GeoStruct
  {
    return GeoStruct(lat: self.lat ?? "", lng: self.long ?? "")
  }
}
