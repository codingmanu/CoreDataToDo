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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
