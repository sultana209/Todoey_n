//
//  SaveServices.swift
//  Todoey
//
//  Created by A K M Saleh Sultan on 1/3/19.
//  Copyright © 2019 A K M Saleh Sultan. All rights reserved.
//

import UIKit
import RealmSwift

class SaveServices: BusinessClass{
    static var sharedInstance = SaveServices()
    
     func save(itemData: Item, cetName: Cetagory){
          
          try! realm.write {
              // itemData.parentCategory = cetName.items
               //cetName.items = itemData
              // itemData.parentCategory = cetName
            
               cetName.items.append(itemData)
           realm.add(itemData)
              
          }
          
        
    }
     
     func savecetToCoreData(cetData: Cetagory){
               
          do {
               try realm.write {
                    realm.add(cetData)
               }
          } catch {
               print("error saving catagory\(error)")
          }
     }
     
     func fetchAll(cetName: Cetagory) -> Results<Item> {
           let realm = try! Realm()
          
          // fetch result using filter
          let results = realm.objects(Item.self).filter("ANY parentCategory.cetaroryName == %@", cetName.cetaroryName)
          /*
           
           //// fetch result using sorted method
        //  let result = cetName.items.sorted(byKeyPath: "title = %@", ascending: true)
        //  print(result)
 
 */
          
          
//          let results = realm.objects(Cetagory.self).first
//          print(results)
         
          // let predicate = NSPredicate(format: "cetaroryName = %@",  cetName.cetaroryName)
         //  print(predicate)
//           let objects = realm.objects(Item.self).filter(predicate)
//           print(objects)
          
        // let arrayOfItems = results?.items.filter(NSPredicate(format: "title = %@ AND ANY parentCategory == %@", cetName.cetaroryName))
//          let arrayOfItems = cetName.items
//          print(arrayOfItems)
         // let item: Results<Item>?
        
          
          //cetName.items.filter(NSPredicate(format: "results?.parentCategory == %@", cetName.cetaroryName))
//          var items:Results<Item>?
//
//          print(arrayOfItems)
//          let itemList: Results<Item>?
//          for myItems in arrayOfItems {
//              myItems.obje
//          }
          
//          let itemsFromList2 = realm.objects(ShoppingList.self).filter("listName = 'List 2'")
//          // Results acts like an Array
//          let shoppingList2 = itemsFromList2.first!
//          // itemList is what you need I think
//          let itemList = shoppingList2.itemList
          
//          let cetList = realm.objects(I.self).filter("cetaroryName = 'cetName.cetaroryName'").first
//
//          let itemList = cetList?.items
//
//          for item in itemList ?? <#default value#> {
//
//          }
//          let predicate = NSPredicate(format: "parentCategory.cetaroryName == %@", cetName.cetaroryName)
//          print(predicate)
//          let itemList = cetName.items.filter(predicate)//realm.objects(Item.self).filter(predicate)
               //cetName.items.filter(<#T##predicate: NSPredicate##NSPredicate#>) sorted(byKeyPath: "cetName.cetaroryName")
          //realm.objects(Person).filter(NSPredicate(format: "ANY dogs.favoriteFoods.id == %@", self.id))
         // let arrayOfItems = realm.objects(Item.self).filter("title = %@ AND ANY parentCategory.cetaroryName = %@", cetName.cetaroryName)
        //  print(arrayOfItems)
          
//          let cetagory = realm.objects(Cetagory.self).filter("cetaroryName = %@ ", cetName.cetaroryName)
//          for canteen in canteens {
//               for line in canteen.lines.filter("ANY meals.vegan = true") {
//                    for meal in line.meals.filter("vegan = true") {
//                         // do something with your vegan meal
//                    }
//               }
//          }
          
//          let predicate = NSPredicate(format: "parentCategory = %@", cetName.cetaroryName)
//       var   itemList = realm.objects(Item.self).filter(predicate)
         // let realm = try! Real()
         // let itemList: Results<Item> = { realm.objects(Item.self)} ()
          
          return results
     
         
 }
     
     
     func fetchAllCet() -> Results<Cetagory>{
          let realm = try! Realm()
          let cetagoryList: Results<Cetagory> = { realm.objects(Cetagory.self)} ()

     return cetagoryList
     }
     
     func UpdateitemInfo(itemInfo: Item) {
          
          do {
               
               try realm.write {
                    itemInfo.done = !itemInfo.done
                   // realm.add(itemInfo, update: true)
                    realm.create(Item.self, value: itemInfo, update: true)
               }
               
          } catch {
               print("error occured during updating...\(error)")
          }
     }
     
     func UpdateCetagoryName(cetInfo: Cetagory) {
          
        
     }
     
     func deleteItemData(itemInfo: Item) {

          do {
               try realm.write {
                    realm.delete(itemInfo)
               }
               
          } catch {
               print("error occured during dletion..\(error)")
          }

     }
     
     func deleteCetagoryData(cetInfo: Cetagory) {

          do {
               try realm.write {
                    let items = realm.objects(Item.self).filter("ANY parentCategory.cetaroryName == %@", cetInfo.cetaroryName)
                    realm.delete(items)
                    realm.delete(cetInfo)
               }
               
          } catch {
               print("error occured during dletion..\(error)")
          }
     }
}
