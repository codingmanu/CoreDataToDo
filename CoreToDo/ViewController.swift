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
        let cell = tableView.dequeueReusableCell(withIdentifier: "protoCell", for: indexPath)
        
        let task = tasks[indexPath.row]
        
        cell.textLabel?.text = task.name!
        
        switch task.importance {
        case 0:
            cell.detailTextLabel?.text = "Normal"
            cell.detailTextLabel?.textColor = UIColor.gray
        case 1:
            cell.detailTextLabel?.text = "Important"
            cell.detailTextLabel?.textColor = UIColor.orange
        case 2:
            cell.textLabel?.textColor = UIColor.red
            cell.detailTextLabel?.text = "Critical"
            cell.detailTextLabel?.textColor = UIColor.red
        default:
            print(task.importance)
        }
                
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
    
    //using the "showDetail" segue to open a new page with a bigger view of the task
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: tasks[indexPath.row])
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail"{
            let guest = segue.destination as! detailViewController
            let senderObj = sender as! Task
            
            guest.task = senderObj
        }else if segue.identifier == "addTask"{
            print(segue.destination)
        }
        
    }
    
}

