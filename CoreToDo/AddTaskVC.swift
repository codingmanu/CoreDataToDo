//
//  AddTaskVC.swift
//  CoreToDo
//
//  Created by Manuel S. Gomez on 12/6/16.
//  Copyright © 2016 Manuel S. Gomez. All rights reserved.
//

import UIKit

class AddTaskVC: UIViewController {
    
    //Linking the view items into the code
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var importanceSwitch: UISegmentedControl!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.text = ""
        importanceSwitch.selectedSegmentIndex = 0
    }
    
    
    //Saves the data from screen into CoreData when the button is clicked
    
    @IBAction func addButtonTapped(_ sender: Any?) {
                
        if textField.text!.isEmpty == false {
            //Always create a context for coredata
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            //We create a task of type "Task" (from coredata).
            let task = Task(context: context)
            
            //we save the name and the importance onto coredata.
            task.name = textField.text!
            task.importance = Int64(importanceSwitch.selectedSegmentIndex)
            
            //save the context
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            //close the actual window
            navigationController!.popViewController(animated: true)
            
        }
        
    }
}
