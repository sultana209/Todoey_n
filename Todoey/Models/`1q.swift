//
//  Cetagory.swift
//  Todoey
//
//  Created by A K M Saleh Sultan on 1/11/19.
//  Copyright © 2019 A K M Saleh Sultan. All rights reserved.
//

import UIKit
import RealmSwift

class Cetagory: Object {
      
    @objc dynamic var cetaroryName: String = ""
    
    let items = List<Item>()
      
//      init(cName: String) {
//           self.cetaroryName = cName
//      }
//    
//    required init() {
//        fatalError("init() has not been implemented")
//    }
    
    
    
    
    //
//    required init(realm: RLMRealm, schema: RLMObjectSchema) {
//        fatalError("init(realm:schema:) has not been implemented")
//    }
    
//     init(cetData: CetagoryName){
//          self.cetaroryName = cetData.cetName!
//
//     }
}

extension Cetagory{
      
//      public class func getData() -> [Cetagory] {
////            return [
////                  Cetagory(cName: "Office Work"),
////                  Cetagory(cName: "Umar"),
////                  Cetagory(cName: "HomeWork")
////
////            ]
//      }
}
