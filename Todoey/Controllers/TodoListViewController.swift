//
//  ViewController.swift
//  Todoey
//
//  Created by Julia Layne on 3/6/18.
//  Copyright © 2018 Julia codes. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("TodoListItems.plist")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

//        var newItem = TodoListItem("Find Mike")
//        itemArray.append(newItem)
//        newItem = TodoListItem("Buy Eggos")
//        itemArray.append(newItem)
//        newItem = TodoListItem("Destroy the Demogorgon")
//        itemArray.append(newItem)
        
        
        //loadItems()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        return cell
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row].title)
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveItems()
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - add new items
    @IBAction func addButtonPressed(_ sender: Any) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert )
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what happens when the user clicks Add Item button
            print(textField.text!)
            if textField.text != nil {

                let addedItem = Item(context: self.context)
                addedItem.title = textField.text!
                self.itemArray.append(addedItem)
                self.saveItems()
                self.tableView.reloadData()
            }
            
        }
        alert.addAction(action)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "create new item"
            textField = alertTextField
            
        }
        
        present(alert, animated: true, completion: nil)
        
    }
    func saveItems(){
        let encoder = PropertyListEncoder()
        do{
            try context.save()
        }catch{
            print("Error saving, \(error)")
        }
    }
//    func loadItems(){
//        if let data = try? Data(contentsOf: dataFilePath!){
//            let decoder = PropertyListDecoder()
//            do{
//
//            }catch{
//                print("Error loading: \(error)")
//            }
//
//        }
//    }

}

