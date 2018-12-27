//
//  TodoListViewController.swift
//  Todoey
//
//  Created by A K M Saleh Sultan on 12/20/18.
//  Copyright © 2018 A K M Saleh Sultan. All rights reserved.
//

import UIKit

class TodoListViewController: UIViewController {
    
    @IBOutlet weak var ToDOtableView: UITableView!
    
    var lastSelection: IndexPath!
    var itemArray = TodoItem.getData()
    var defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.title = "ToDoey"
        let addBarBtn = UIBarButtonItem(image: UIImage(named: "add"), style: .done, target: self, action: #selector(addItemTapped))
        self.navigationItem.rightBarButtonItem = addBarBtn
     
        let itemData = defaults.data(forKey: Contacts.TodoList.todoItem)
       itemArray = try! JSONDecoder().decode([TodoItem].self, from: (itemData ?? nil)!)
        print(itemArray)
        
     
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
        self.itemArray.insert(TodoItem(name: itemName), at: 0)
        
        let itemData = try! JSONEncoder().encode(itemArray)
        defaults.set(itemData, forKey: Contacts.TodoList.todoItem)
    
      
       // self.itemArray.append(TodoItem(name: itemName))
        
        self.ToDOtableView.beginUpdates()
        self.ToDOtableView.insertRows(at: [IndexPath.init(row: 0, section: 0)], with: .top)
        self.ToDOtableView.endUpdates()
        
    }


}

extension TodoListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        ToDOtableView.deselectRow(at: indexPath, animated: true)
        
        if let cell = self.ToDOtableView.cellForRow(at: indexPath){
            if cell.accessoryType == .checkmark {
                cell.accessoryType = .none
            } else {
              cell.accessoryType = .checkmark
          }
        }
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
     //   self.ToDOtableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if indexPath.row < itemArray.count {
            itemArray.remove(at: indexPath.row)
            ToDOtableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    
}
