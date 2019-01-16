//
//  Cetagory.swift
//  Todoey
//
//  Created by A K M Saleh Sultan on 1/11/19.
//  Copyright © 2019 A K M Saleh Sultan. All rights reserved.
//

import UIKit

class Cetagory {
      
      var cetaroryName: String = ""
      
      init(cName: String) {
           self.cetaroryName = cName
      }
      
      init() {
            
      }
     
     init(cetData: CetagoryName){
          self.cetaroryName = cetData.cetName!
         
     }
}

extension Cetagory{
      
      public class func getData() -> [Cetagory] {
            return [
                  Cetagory(cName: "Office Work"),
                  Cetagory(cName: "Umar"),
                  Cetagory(cName: "HomeWork")
                
            ]
      }
}
