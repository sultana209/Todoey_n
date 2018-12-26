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
    var itemArray = ["egg", "Vegatable", "Milk"]

    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.title = "ToDoey"
    }


}

extension TodoListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
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
    
    
}
