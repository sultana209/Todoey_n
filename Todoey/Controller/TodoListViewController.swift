//
//  TodoListViewController.swift
//  Todoey
//
//  Created by A K M Saleh Sultan on 12/20/18.
//  Copyright © 2018 A K M Saleh Sultan. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UIViewController {
    
    @IBOutlet weak var ToDOtableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var lastSelection: IndexPath!
    //var itemArray = TodoItem.getData()
      
      var itemArray: Results<Item>?
    var defaults = UserDefaults.standard
      var todo_title: String = ""
      var selectedcetagory : Cetagory?{
            didSet{
                loadData()
            }
      }
      
      var filteritemArray: Results<Item>?
      var inSarcheMood: Bool = false
   // var tappedItem: Bool?
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.title = todo_title
        let addBarBtn = UIBarButtonItem(image: UIImage(named: "add"), style: .done, target: self, action: #selector(addItemTapped))
        self.navigationItem.rightBarButtonItem = addBarBtn
        

         loadData()
//        let mydata = defaults.dictionary(forKey: Contacts.TodoList.todoItem)
//        print(mydata)
//         let data = mydata?["Contacts.TodoList.todoItem"] as! String
//        print(data)
//        itemArray.append(TodoItem(name: data))
        
      //  print(itemArray)
      
      // applying search Controller
      searchBar.returnKeyType = .done
      
//      let search = UISearchController(searchResultsController: nil)
//      search.searchResultsUpdater = self
//      search.obscuresBackgroundDuringPresentation = false
//      search.searchBar.placeholder = "Type searching here to search"
//      navigationItem.searchController = search
//      definesPresentationContext = true
     // ToDOtableView.tableHeaderView = search.searchBar
        
     
    }
    
    @objc func addItemTapped(_sender: UIBarButtonItem) {
        print("add btn tapped")
        
        let alert = UIAlertController(title: "Add new to - do item", message: "Insert the title of the new to-do item:", preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: nil)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
       
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            if let title = alert.textFields?[0].text
            {
                self.saveItem(itemName: title)
              
                self.ToDOtableView.reloadData()
            }        }))
        present(alert, animated: true, completion: nil)
    }
    
    func saveItem(itemName: String) {
      //  self.itemArray.insert(TodoItem(name: itemName), at: 0)
       // self.itemArray.insert(Item(name: itemName, done: false), at: 0)
      
      let item = Item()
    
        item.title = itemName
        //item.done = false
     
        saveInfo(itemInfo: item)

      itemArray = realm.objects(Item.self).filter("ANY parentCategory.cetaroryName == %@", selectedcetagory?.cetaroryName)
      
      //  self.itemArray.append(TodoItem(name: itemName))
      
        self.ToDOtableView.beginUpdates()
        self.ToDOtableView.insertRows(at: [IndexPath.init(row: 0, section: 0)], with: .top)
        self.ToDOtableView.endUpdates()
        
    }
    
    func loadData() {
      
      // using coreData
      
     // itemArray = SaveServices.sharedInstance.fetchAll(cetName: todo_title)
       itemArray = SaveServices.sharedInstance.fetchAll(cetName: (selectedcetagory)!)
      
      /* // using  Codeable and plist
        // using PropertyListDecoder()
        let decoder = PropertyListDecoder()
        do {
        let data = try Data(contentsOf: dataFilePath!)
            itemArray = try decoder.decode([TodoItem].self, from: data)
        } catch {
            print("error ouccured during decoding...")
        }
       /*
        // using JsonDecoder
        if let itemData = defaults.data(forKey: Contacts.TodoList.todoItem){
            itemArray = try! JSONDecoder().decode([TodoItem].self, from: (itemData ?? nil)!)
        }
 */
 */
    }
    
    func saveInfo(itemInfo: Item) {



       // SaveServices.sharedInstance.save(itemData: itemInfo)
      SaveServices.sharedInstance.save(itemData: itemInfo, cetName: (selectedcetagory)!)

        /*  // save data using Codable and plist
     /*
        // using JSONEncoder()
        let itemData = try! JSONEncoder().encode(itemArray)
        defaults.set(itemData, forKey: Contacts.TodoList.todoItem)
        */

        // using PropertyListEncoder()

        let encoder = PropertyListEncoder()

        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("error was occured..")
        }


        //        var settings =  [String: String]()
        //        settings[Contacts.TodoList.todoItem] = itemName
        //        defaults.dictionary(forKey: Contacts.TodoList.todoItem)
 */
    }


}

extension TodoListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     // return itemArray?.count ?? 1
      if inSarcheMood {
            return filteritemArray?.count ?? 1
      }
      return itemArray?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)
     
      let item : Item?
      if  inSarcheMood {
            item = filteritemArray?[indexPath.row]
      } else {
            item = itemArray?[indexPath.row]
      }

      
     
      if let itemindividual = item{
      cell.textLabel?.text = itemindividual.title
        
        let  tappedItem = itemindividual
        
      cell.accessoryType = tappedItem.done == true ? .checkmark : .none
        
//        if tappedItem.chacked {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
      } else  {
            cell.textLabel?.text = "No item added..."
      }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     // var item: Item!
        ToDOtableView.deselectRow(at: indexPath, animated: true)
       /*
        if let cell = self.ToDOtableView.cellForRow(at: indexPath){
            if cell.accessoryType == .checkmark {
                cell.accessoryType = .none
            } else {
              cell.accessoryType = .checkmark
          }
        }
 */
//      if inSarcheMood {
//          //  item = filteritemArray[indexPath.row]
//      } else {
//            item = itemArray?[indexPath.row]
//      }
      if let item = itemArray?[indexPath.row]{
        let  tappedItem = item
            SaveServices.sharedInstance.UpdateitemInfo(itemInfo: tappedItem)
     // tappedItem!.done = !tappedItem!.done
        
     // saveInfo(itemInfo: tappedItem)
      
      }
        ToDOtableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
     //   self.ToDOtableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if indexPath.row < itemArray?.count ?? 1 {
            SaveServices.sharedInstance.deleteItemData(itemInfo: (itemArray?[indexPath.row])!)
           // itemArray.remove(at: indexPath.row)
            ToDOtableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    
}

extension TodoListViewController : UISearchBarDelegate {
      
//      func updateSearchResults(for searchController: UISearchController) {
//
//      }
     func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            view.endEditing(true)
      }
      func searchBar(_ searchBar: UISearchBar, textDidChange searchtext: String) {

            if searchBar.text == nil || searchBar.text == "" {
                  inSarcheMood = false
                  ToDOtableView.reloadData()
                  view.endEditing(true)
            } else {
                  inSarcheMood = true
                //  self.backupContacts.filter({$0.givenName.lowercased().contains(searchText.lowercased()) || $0.familyName.lowercased().contains(searchText.lowercased())})
                 // let leower = searchBar.text!.lowercased()
                //filteritemArray = itemArray.filter({$0.name.range(of: leower) != nil})
                  filteritemArray = realm.objects(Item.self).filter(NSPredicate(format: "%K CONTAINS[c] %@", "title" ,searchtext.lowercased() )).sorted(byKeyPath: "dateCreated", ascending: true)
                  print(filteritemArray?.count)
                 // filteritemArray = itemArray?.filter({$0.name.lowercased().contains(searchtext.lowercased())})
                  ToDOtableView.reloadData()
            }
      }
      
      
      /*
      // another way to fetch the filtered array from core data
 
 
      
      func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

            inSarcheMood = true
       /* //using core data
             let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
            let predicate = NSPredicate(format: "title CONTAINS[cd]  %@" , searchBar.text!)

            request.predicate = predicate

            let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)

            request.sortDescriptors = [sortDescriptor]

           loadafterSearching(with: request)
*/
            // using realm
            
            // filter the filtered array object
            filteritemArray = itemArray?.filter("title CONTAINS [cd] %@", searchBar.text!).sorted(byKeyPath: "title", ascending: true)
           
            /*
            // filter the Main Item array
          let predicate = NSPredicate(format: "%K CONTAINS[c] %@", "title" ,searchBar.text?.lowercased() ?? "no data matched" )
            filteritemArray = realm.objects(Item.self).filter(predicate).sorted(byKeyPath: "title", ascending: true)
*/
            
            print(inSarcheMood)
            print(filteritemArray?.count)
            ToDOtableView.reloadData()
      }

 
 
      func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if searchBar.text == nil || searchBar.text == ""{
                  inSarcheMood = false
                  loadData()
                  ToDOtableView.reloadData()
                  DispatchQueue.main.async {
                        searchBar.resignFirstResponder()
                  }
            }
           
       }
 
//      func loadafterSearching(with request: Results<Item>){
//          //  do {
//              //    let items = try BusinessClass.getContext().fetch(request) as! [Item]
//
////                  for info in items {
////                        filteritemArray.append(TodoItem(itemData: info))
////                  }
////            }catch{
////                  print("error doing fetch....")
////            }
//            print(inSarcheMood)
//          //  print(filteritemArray.count)
//            ToDOtableView.reloadData()
//      }
    */
      
}


