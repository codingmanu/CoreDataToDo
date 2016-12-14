//
//  ViewController.swift
//  CoreToDo
//
//  Created by Manuel S. Gomez on 12/6/16.
//  Copyright © 2016 Manuel S. Gomez. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //Linking the tableview into the code
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sortSwitch: UISegmentedControl!
    
    
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
            cell.textLabel?.textColor = UIColor.black
            cell.detailTextLabel?.text = "Normal"
            cell.detailTextLabel?.textColor = UIColor.gray
        case 1:
            cell.textLabel?.textColor = UIColor.black
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
    
    @IBAction func sortSwitch(_ sender: Any) {
        getData()
    }
    
    //Saving the data from coredata into the tasks array
    func getData(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        //We create a request with NSSortDescriptors to order by name or importance
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        let nameSort = NSSortDescriptor(key: "name", ascending: true, selector: #selector(NSString.caseInsensitiveCompare))
        let importanceSort = NSSortDescriptor(key: "importance", ascending: false)
        
        switch sortSwitch.selectedSegmentIndex {
        case 0:
            request.sortDescriptors = [nameSort]
            tableView.reloadData()
        case 1:
            request.sortDescriptors = [importanceSort]
            tableView.reloadData()
        default:
            break
        }
        do {
            //tasks = try context.fetch(Task.fetchRequest())
            tasks = try context.fetch(request)
        }catch{
            print("Fetching failed")
        }
        
        
    }
    
    
    
    //If you click on any task, the edit task window will appear
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editTask"{
            let guest = segue.destination as! editTaskVC
            if let senderObj = sender as? Task{
                guest.task = senderObj
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "editTask", sender: tasks[indexPath.row])
    }
    
}

