//
//  ViewController.swift
//  CoreToDo
//
//  Created by Manuel S. Gomez on 12/6/16.
//  Copyright © 2016 Manuel S. Gomez. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //Linking the tableview into the code
    @IBOutlet weak var tableView: UITableView!
    
    //Array of coredata Tasks
    var tasks: [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //get the data from coredata
        getData()
        
        //reload the tableview
        tableView.reloadData()
    }
    
    //Necessary function 1
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    //Necessary funciont 2
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let task = tasks[indexPath.row]
        
        switch task.importance {
        case 0:
            cell.textLabel?.text = "⭕️\(task.name!)"
        case 1:
            cell.textLabel?.text = "❗️\(task.name!)"
        case 2:
            cell.textLabel?.text = "‼️\(task.name!)"
        default:
            cell.textLabel?.text = "Error"
        }
        
        /*if task.isImportant{
            cell.textLabel?.text = "😂\(task.name!)"
        }else{
            cell.textLabel?.text = task.name
        }*/
        
        return cell
    }
    
    //deleting the task
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let task = tasks[indexPath.row]
        
        if editingStyle == .delete {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            context.delete(task)
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            do {
                tasks = try context.fetch(Task.fetchRequest())
            }catch{
                print("Fetching failed")
            }
        }
        tableView.reloadData()
        
    }
    
    
    //Saving the data from coredata into the tasks array
    func getData(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            tasks = try context.fetch(Task.fetchRequest())
        }catch{
            print("Fetching failed")
        }
        
        
    }
}

