//
//  ViewController.swift
//  Todoey
//
//  Created by Moh on 17/05/2023.
//  Copyright © 2023 Game X. All rights reserved.
//

import UIKit

//. STEP 1
//change the UIViewController to UITableViewController to bond the
//tableview and storyboard together
//then change the swift file name to TodoListViewController and the class too
//change the tableViewController class identifier in the main.storyboard,in
//the propoperty section to TodoListViewController
//change the prototype cell identifier from the propeties section to
// ToDoItemCell
// Add a navigationController from Edit > Embed > NAvigation Controller
//Add a title to the navigationController as well
class TodoListViewController: UITableViewController {
    
//<=====================================TABLEVIEW DATASOURCE METHODS=========================================>
    
//. STEP 2
    //create an array to store all items to be displayed
    //. user defaulsts is used to store key value data
    //. assign the defaults made in STEP 5 to itemArray, to be able to display data when the app is restored
    //  to it's previous state
    
    //. STEP 8
    //. convert the itemArray to an Item class object created at STEP 6
    var itemArray = [Item]()
    
    //. STEP 13
    //. create a file path to document directory as an array and retrive the first element of the array
    //. this method is used since userdefaults isnt releable in data persistence, then add this to
    //. Items.plist
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    //. STEP 14
    //. comment out the userDefaults
    //let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(dataFilePath  )
        
        
        //. STEP 7
        //. crate newItem from item.swift (item class) and append it to the itemArray
        
        //. STEP 26
        //. comment STEP 7 and add decodable to the item class.swift
        
//        let newItem = Item()
//        newItem.title = "Grind"
//        itemArray.append(newItem)
//
//        let newItem2 = Item()
//        newItem2.title = "Exercise"
//        itemArray.append(newItem2)
//
//        let newItem3 = Item()
//        newItem3.title = "Sleep"
//        itemArray.append(newItem3)
        
        //. when the app loads, we pull out an array for user default, with the key TodoListArray as an
        //. array of Items, then we set itemArray to items
//        if let items = defaults.array(forKey: "TodoListArray") as? [Item]{
//            itemArray = items
//        }
        //. STEP 18
        //. comment out the if statement
        
        //. STEP 24
        //.create a loadItems method to replace the hard coded inputs in STEP 7
        loadItems()
    }

//. STEP 3
    //. Add tableview Datasources methods to display data from Array
    //. dequeuReusableCell simple means that the cell will be reused, once screen real estate is used up
    //. that is when scrolling down the first cell disappears till the last cell is displayed, and the check
    //. mark will be included as well
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        //. STEP 10
        //. check if the current Selected cell has is done then add a check mark if not add nothing
        
        // <== SWIFT TERNARY OPERATOR ==>
        //VALUE  = CONDITION ? VALUEIFTRUE : VALUEIFFALSE
        
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        }else {
//            cell.accessoryType = .none
//        }
        cell.accessoryType = item.done ? .checkmark : .none
        return cell
    }

// MARKK - TABLEVIEW DELAGATES METHOD
    
    //. STEP 4
    //. this is for the selected cell in the screen, cell display color, animation etc
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        //. add a checkmark to the current selected cell[indexPath]. This method uses the protocell category
        //. property to insert a checkmark.
        
        //. STEP 9
        //. check if the current selected is done,
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        //. STEP 22
        //. call the saveItems() after adding check mark in STEP 9 above
        saveItems()

        
        //. STEP 11
        //. Comment this 3 lines
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        }else {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
        //. STEP 12
        //. a reload() to show the check mark on the current selected text
        // tableView.reloadData()
        
        //. STEP 23
        //. comment STEP 12
        
        //cell display animation
        tableView.deselectRow(at: indexPath, animated: true)
    }
 //<================================================ END ====================================================>
    
// <================================= MARK - ADD NEW ITEMS (BAR BUTTON)======================================>
    
    //. STEP 5
    //. add a barButton, connect it
    //. create an aleart and add a textfield inside
    //. append the textField.tex to the array up in STEP 2
    //. use reloadDatat() function to display the newly added item
    //. append the textfield text to the itemArray
    //. save the itemArray to the user default created in STEP 2
    //. defaults is used for data persistency when the app is closed, it maintains the prevailing states
    //. defaults is saved in infoplist, it's saves both key and values 
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Todoey Item", message: "", preferredStyle: .alert)
        //aleart add button text
        let action = UIAlertAction(title: "Add new Item", style: .default) { (action) in
            //What will happen once the user clicks the Add Item button of our Alert
            //. create a new item, set its title property from the textfield. the done is set to false by
            //. by default in the Item.swift. Then we append the newItem to the itemArray
            //. then we set it to user defaults using the TodoListArray Key
            //. reload() is used for displaying new  data
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
        }
            //. STEP 21
            //. call the saveItems function
            saveItems()
            
            //. STEP 15
            //. comment out defaults
            //self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            //. STEP 16
            //. we use enoder instead of userdefaults for data persistence. we encode the data and write it
            //. to our data file path and modify the Item.swift class to accomodate the encode
//            let encoder = PropertyListEncoder()
//            do{
//                let data = try encoder.encode(self.itemArray)
//                try data.write(to: self.dataFilePath!)
//            }catch{
//                print("Error Encoding item array, \(error)")
//            }
//
//            self.tableView.reloadData()
//
//        }
        //. STEP 19
        //. coment STEP 16, copy it and move it to a function on it's own since we want to include the check
        //. mark, once a todo is done. this is done in STEP 20
        
        //. add a text field in the alert
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
  //}
    

        
}
//<================================================ END =====================================================>

//<======================================= MODEL MANIPULATION METHODS =======================================>
//. STEP 20
//. create a new saveItem function
    func saveItems() {
        let encoder = PropertyListEncoder()
            do{
                let data = try encoder.encode(itemArray)
                try data.write(to: dataFilePath!)
            }catch{
                print("Error Encoding item array, \(error)")
            }
            
            self.tableView.reloadData()
    
}
//. STEP 25
    //. define the loadItems method here, which loads items automatically to the plist
    //. create a variable from the contents of the datafile path
    //. decode the data and assign it to the itemArray
    func loadItems(){
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            }catch{
                print("There wan an error decoding item array, \(error)")
            }
        }
    }
}
