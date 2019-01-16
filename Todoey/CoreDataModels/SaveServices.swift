//
//  SaveServices.swift
//  Todoey
//
//  Created by A K M Saleh Sultan on 1/3/19.
//  Copyright © 2019 A K M Saleh Sultan. All rights reserved.
//

import UIKit
import CoreData

class SaveServices: BusinessClass{
    static var sharedInstance = SaveServices()
    
     func save(itemData: TodoItem, cetName: String){
    //func save(itemData: TodoItem) {
     
     if let data = NSManagedObject(entity: NSEntityDescription.entity(forEntityName: "Item", in: BusinessClass.getContext())!, insertInto: BusinessClass.getContext()) as? Item {
          
          //let cetdata = NSManagedObject(entity: NSEntityDescription.entity(forEntityName: "CetagoryName", in: BusinessClass.getContext())!, insertInto: BusinessClass.getContext()) as? CetagoryName
          
          let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CetagoryName")
         // var cetInfo = [Cetagory]()
          fetchrequest.predicate = NSPredicate(format: "cetName == %@", cetName)
          print("predicate is",  fetchrequest.predicate)
     
               let cets = try! BusinessClass.getContext().fetch(fetchrequest) as! [CetagoryName]
          print(cets)
          
          for info in cets {
          
               if info.cetName == cetName{
                    print(info.cetName)
                    data.title = itemData.name
                    data.done = itemData.chacked
                   // cetdata?.cetName = cetName
                    //          let rel = data.mutableSetValue(forKey: (cetdata?.cetName)!)
                    //          rel.add(data)
                    //data.toCetagory = info
//                    info.setValue(NSSet(object: data), forKey: "toItems")
//                    print(info)
//                    info.addToToItems(data)
//                    print(info)
                   
                   info.addToToItems(data)
                   // print(data.toCetagory)
               }
          }
         
         
          
          
          do {
               try BusinessClass.getContext().save()
               print("data saved....")
          } catch let err as NSError {
               print("Could not saved. \(err), \(err.userInfo)")
          }
     }
     
        
    }
     
     func savecetToCoreData(cetData: Cetagory){
               
               if let data = NSManagedObject(entity: NSEntityDescription.entity(forEntityName: "CetagoryName", in: BusinessClass.getContext())!, insertInto: BusinessClass.getContext()) as? CetagoryName {
               
                    data.cetName = cetData.cetaroryName
               
               do {
                    try BusinessClass.getContext().save()
                    print("data saved....")
               } catch let err as NSError {
                    print("Could not saved. \(err), \(err.userInfo)")
               }
          }
     }
     
     func fetchAll(cetName: String) -> [TodoItem]{
          

     
          let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CetagoryName")
         let itemPredicate = NSPredicate(format: "cetName == %@", cetName)
          fetchrequest.predicate = itemPredicate
          print(fetchrequest.predicate)
         var itemInfo = [TodoItem]()
          itemInfo.removeAll()
          do {
          let items = try BusinessClass.getContext().fetch(fetchrequest) as! [CetagoryName]
               print(items)
               for info in items {
                    print(info)
                    let i_info = info.toItems
                    print(i_info)
                    let array = i_info.allObjects as! [Item]
                   
                    print(array)
                    for a in array {
                         itemInfo.append(TodoItem(itemData: a) )
                    }
                  // itemInfo.append(TodoItem(itemData: i_info) )
               }
              
          } catch let err as NSError{
               
               print(err)
 }
        /*
          let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
          let itemPredicate = NSPredicate(format: "\(#keyPath(Item.CetagoryName.cetName)) == %@", cetName)
          fetchrequest.predicate = itemPredicate
          print(fetchrequest.predicate)
          var itemInfo = [TodoItem]()
          itemInfo.removeAll()
          do {
               let items = try BusinessClass.getContext().fetch(fetchrequest) as! [Item]
               print(items)
               for info in items {
                    print(info)
//                    let i_info = info.toItems
//                    print(i_info)
                    
                    itemInfo.append(TodoItem(itemData: info) )
               }
               
          } catch let err as NSError{
               
               print(err)
          }
 
 */
          print( itemInfo.count)
          return itemInfo
     }
     
     func fetchAllCet() -> [Cetagory]{
          
          let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CetagoryName")
          var cetInfo = [Cetagory]()
          cetInfo.removeAll()
          do {
               let cets = try BusinessClass.getContext().fetch(fetchrequest) as! [CetagoryName]
              
               for info in cets {
                  cetInfo.append(Cetagory(cetData: info))
               }
               
          } catch let err as NSError {
               
               print(err)
          }
          print( cetInfo.count)
          return cetInfo
     
     }
     
     func UpdateitemInfo(itemInfo: TodoItem) {
          
          let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Item")
          
          fetchRequest.predicate = NSPredicate(format: "title == %@", itemInfo.name)
          print("predicate is",  fetchRequest.predicate)
          
          var updateItemMode = [TodoItem]()
          
          do {
               if let data = try BusinessClass.getContext().fetch(fetchRequest).first as? Item
               {
                    data.done = itemInfo.chacked
                    print("after edit:", data)
               }
               
               do{
                    try BusinessClass.getContext().save()
                    print("data saved..")
                    
               } catch let err as NSError {
                    print("could not save...\(err), \(err.userInfo)")
               }
          }catch let err as NSError {
                    print("could not update...\(err), \(err.userInfo)")
          }
          
     }
     
     func UpdateCetagoryName(cetInfo: Cetagory) {
          
          let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CetagoryName")
          
          fetchRequest.predicate = NSPredicate(format: "cetName == %@", cetInfo.cetaroryName)
          print("predicate is",  fetchRequest.predicate)
          
          //var updateCetagoryMode = [Cetagory]()
          
          do {
               if let data = try BusinessClass.getContext().fetch(fetchRequest).first as? CetagoryName
               {
                    data.cetName = cetInfo.cetaroryName
                    print("after edit:", data)
               }
               
               do{
                    try BusinessClass.getContext().save()
                    print("data saved..")
                    
               } catch let err as NSError {
                    print("could not save...\(err), \(err.userInfo)")
               }
          }catch let err as NSError {
               print("could not update...\(err), \(err.userInfo)")
          }
     }
     
     func deleteItemData(itemInfo: TodoItem) {
          
          let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
          let predicated = NSPredicate(format: "title == %@", itemInfo.name)
          fetchrequest.predicate = predicated
          
          do{
               let datas = try BusinessClass.getContext().fetch(fetchrequest)
               for data in datas{
                    BusinessClass.getContext().delete(data as! NSManagedObject)
               }
               try BusinessClass.getContext().save()
          } catch let err as NSError {
               print("could not delete..\(err), \(err.userInfo)")
          }
     }
     
     func deleteCetagoryData(cetInfo: Cetagory) {
          let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CetagoryName")
          let predicated = NSPredicate(format: "cetName == %@", cetInfo.cetaroryName)
          fetchrequest.predicate = predicated
          
          do{
               let datas = try BusinessClass.getContext().fetch(fetchrequest)
               for data in datas{
                    BusinessClass.getContext().delete(data as! NSManagedObject)
               }
               try BusinessClass.getContext().save()
          } catch let err as NSError {
               print("could not delete..\(err), \(err.userInfo)")
          }
     }
}
