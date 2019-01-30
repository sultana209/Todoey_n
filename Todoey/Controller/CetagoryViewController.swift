//
//  CetagoryViewController.swift
//  Todoey
//
//  Created by A K M Saleh Sultan on 1/11/19.
//  Copyright © 2019 A K M Saleh Sultan. All rights reserved.
//

import UIKit
import RealmSwift

class CetagoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

      @IBOutlet weak var cetagoryTB: UITableView!
      
      var cetName: String = ""
      
     // var cetagoryList = [Cetagory]()
    var cetagoryList: Results<Cetagory>?
   
//    let realm = try! Realm()
//    lazy var cetagoryList: Results<Cetagory> = { self.realm.objects(Cetagory.self)}()
    
    var  i_indexPath: IndexPath? = nil
      override func viewDidLoad() {
        super.viewDidLoad()
            
            self.title = "Cetagory"
            
            let addBarBtn = UIBarButtonItem(title: "add cetagory", style: .done, target: self, action: #selector(addCetagory))
            self.navigationItem.rightBarButtonItem = addBarBtn

       // print(cetagoryList.count)
          loadCetData()
       
    }
      
      @objc func addCetagory(_ sender: UIBarButtonItem) {
            print("cetagory btn tapped")
            
            let alert = UIAlertController(title: "Add new Cetagory", message: "Insert the title of the new Cetagory:", preferredStyle: .alert)
            
            alert.addTextField(configurationHandler: nil)
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
                  if let title = alert.textFields?[0].text
                  {
                        self.saveCetagory(ceagoryName: title)
                        
                        self.cetagoryTB.reloadData()
                  }        }))
            present(alert, animated: true, completion: nil)
      }
     
     
     func loadCetData() {
          
          
//        let  cetList =  SaveServices.sharedInstance.fetchAllCet()
//        cetagoryList = Array(cetList)
        
         cetagoryList =  SaveServices.sharedInstance.fetchAllCet()
       
     }
      func saveCetagory(ceagoryName: String) {
           
           // self.cetagoryList.insert(Cetagory(cName: ceagoryName), at: 0)
           // self.itemArray.insert(TodoItem(name: itemName, done: false), at: 0)
        
            let cet = Cetagory()
            cet.cetaroryName = ceagoryName

        // self.cetagoryList.append(cet)
       // cetagoryList = Array(realm.objects(Cetagory.self))
        
            saveCetData(cetInfo: cet)
          
          cetagoryList = realm.objects(Cetagory.self)
          
            // self.cetagoryList.append(Cetagory(cName: ceagoryName))
          
            self.cetagoryTB.beginUpdates()
            self.cetagoryTB.insertRows(at: [IndexPath.init(row: 0, section: 0)], with: .top)
            self.cetagoryTB.endUpdates()
      }
     
     func saveCetData(cetInfo: Cetagory) {
           SaveServices.sharedInstance.savecetToCoreData(cetData: cetInfo)
     }
    

     func numberOfSections(in tableView: UITableView) -> Int {
          return 1
     }
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return cetagoryList?.count ?? 1
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cetCell", for: indexPath)
            
        cell.textLabel?.text = cetagoryList?[indexPath.row].cetaroryName ?? "NO Cetagories added"
            
            return cell
      }
      
      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
        cetName = cetagoryList?[indexPath.row].cetaroryName ?? "no cet selected"
        i_indexPath = tableView.indexPathForSelectedRow
            
            performSegue(withIdentifier: "gotoIItemTodoVC", sender: self)
      }
     
     
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if indexPath.row < cetagoryList?.count ?? 1 {
            SaveServices.sharedInstance.deleteCetagoryData(cetInfo: (cetagoryList?[indexPath.row])!)
              // cetagoryList.remove(at: indexPath.row)
           
            
               cetagoryTB.deleteRows(at: [indexPath], with: .automatic)
               cetagoryTB.reloadData()
          }
     }
      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           
            let destination = segue.destination as! TodoListViewController
            destination.todo_title = cetName
        
        destination.selectedcetagory = cetagoryList?[(i_indexPath?.row)!]
            
      }
      
    

}
