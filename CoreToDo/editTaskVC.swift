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
    
    //Task we want to edit (passed from another view)
    var task:Task?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //We assign the task info to the screen items
        if task != nil {
            textField.text = task!.name
            importanceSwitch.selectedSegmentIndex = Int((task!.importance))
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        //We update the task
        if textField.text != nil && task != nil {
            task!.name = textField.text!
            task!.importance = Int64(importanceSwitch.selectedSegmentIndex)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
        }
        
        //Close the current VC
        self.navigationController!.popToRootViewController(animated: true)
    }
    
}

