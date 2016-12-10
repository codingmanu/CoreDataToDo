//
//  editTaskVC.swift
//  CoreToDo
//
//  Created by Manuel S. Gomez on 12/9/16.
//  Copyright © 2016 Manuel S. Gomez. All rights reserved.
//

import UIKit

class editTaskVC: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var importanceSwitch: UISegmentedControl!
    
    //Creating two variables so we can access them from the prepareSegue function
    var text = "error"
    var importance = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.text = text
        importanceSwitch.selectedSegmentIndex = importance
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        if textField.text != nil {
            //Always create a context for coredata
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            print((UIApplication.shared.delegate as! AppDelegate).persistentContainer.name)
            
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
