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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
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
        print(itemArray[indexPath.row].title!)
        //itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        context.delete(itemArray[indexPath.row])
        itemArray.remove(at: indexPath.row)
        saveItems()
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
                addedItem.done = false
                self.itemArray.append(addedItem)
                self.saveItems()
                self.loadItems()
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
         do{
            try context.save()
        }catch{
            print("Error saving, \(error)")
        }
        self.tableView.reloadData()
    }
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()){
        //let request : NSFetchRequest<Item> = Item.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        do{
            itemArray = try context.fetch(request)
        }catch{
            print("error fetching data from context \(error)")
        }
        self.tableView.reloadData()
    }


}
//MARK: - Search Bar Methods
extension TodoListViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if (searchBar.text?.count == 0){
            loadItems()
            searchBar.resignFirstResponder()
        }else{
            let request : NSFetchRequest<Item> = Item.fetchRequest()
            request.predicate = NSPredicate(format: "title CONTAINS[cd] %@",  searchBar.text!)
            //request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
            loadItems(with: request)
            print(searchBar.text!)
        }
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("Ended edit")
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("Cancel")
        searchBarSearchButtonClicked(searchBar)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("text change")
        searchBarSearchButtonClicked(searchBar)
    }
    

}

