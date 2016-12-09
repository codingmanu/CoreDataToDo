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
    
    //Creating two variables so we can access them from the prepareSegue function
    var text = "eee"
    var importance = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = text
        importanceSwitch.selectedSegmentIndex = importance
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
