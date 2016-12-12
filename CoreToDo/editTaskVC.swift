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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        deleteTask()
        insertTask()
        
        //close the current VC
        self.navigationController?.popToRootViewController(animated: true)
    }

    
    func deleteTask(){
        //we get all the tasks in coredata
        var tasks: [Task] = [] 
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            tasks = try context.fetch(Task.fetchRequest())
        }catch{
            print("Fetching failed")
        }
        
        //check all tasks in array and delete the current one
        var task: Task
        for i in 0..<tasks.count{
            if tasks[i].name == text{
                task = tasks[i]
                context.delete(task)
            }
        }
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    
    func insertTask(){
        if textField.text != nil {
            //Always create a context for coredata
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            //We create a task of type "Task" (from coredata).
            
            let task = Task(context: context)
            
            //we save the name and the importance onto coredata.
            task.name = textField.text!
            task.importance = Int64(importanceSwitch.selectedSegmentIndex)
            
            //save the context
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
        }
    }
}
