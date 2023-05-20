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
    
    //MARK  - TABLEVIEW DATASOURCE METHODS
    
//. STEP 2
    //create an array to store all items to be displayed
    var itemArray = ["Exercise","Conqure","Repeat"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

//. STEP 3
    //. Add tableview Datasources methods to display data from Array
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }

// MARKK - TABLEVIEW DELAGATES METHOD
    
    //. STEP 4
    //. this is for the selected cell in the screen, cell display color, animation etc
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        //add a checkmark to the current selected cell[indexPath]. This method uses the protocell category
        //property to insert a checkmark.
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        //cell display animation
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK - ADD NEW ITEMS (BAR BUTTON)
    
    //. STEP 5
    //. add a barButton, connect it
    //. create an aleart and add a textfield inside
    //. append the textField.tex to the array up in STEP 2
    //. use reloadDatat() function to display the newly added item
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Todoey Item", message: "", preferredStyle: .alert)
        //aleart add button text
        let action = UIAlertAction(title: "Add new Item", style: .default) { (action) in
            //What will happen once the user clicks the Add Item button of our Alert
            self.itemArray.append(textField.text!)
            self.tableView.reloadData()
            
        }
        //. add a text field in the alert
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}


