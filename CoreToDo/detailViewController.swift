//
//  detailViewController.swift
//  CoreToDo
//
//  Created by Manuel S. Gomez on 12/7/16.
//  Copyright © 2016 Manuel S. Gomez. All rights reserved.
//

import UIKit

class detailViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var importanceSwitch: UISegmentedControl!
    
    //Task we want to edit (passed from another view)
    var task:Task?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //We assign the task info to the screen items
        if task != nil {
            label.text = task?.name
            importanceSwitch.selectedSegmentIndex = Int((task?.importance)!)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func editButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "editTask", sender: self )
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editTask"{
            
            //We send the task to the editTaskVC screen
            
            let guest = segue.destination as! editTaskVC
            guest.task = task
        }
        
        
    }
}
