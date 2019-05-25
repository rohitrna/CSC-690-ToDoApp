//
//  ViewController.swift
//  todoApp
//
//  Created by Rohit Nair on 3/29/19.
//  Copyright © 2019 Rohit Nair. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,AddTask, ChangeButton {
    var tasks: [Task] = []
    var store = UserDefaults.standard
    @IBOutlet weak var tableView: UITableView!
    
    func changeButton(checked: Bool, index: Int) {
        tasks[index].checked = checked
        tableView.reloadData()
    }

    override func viewDidLoad() {
        tableView.backgroundView = UIImageView(image: UIImage(named: "stackedpostits"))
        let decoder =  JSONDecoder()
        if
            let storedTasks = store.data(forKey: "tasks"),
            let tasks = try? decoder.decode(Array<Task>.self , from : storedTasks)
            {
                
                self.tasks = tasks
        
            }
    }
    
    //Editing and Deleting rows
    //On swiping a cell rightwards a user will be able to edit or delete he content of a cell
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let etask = tasks[indexPath.row]
        let editButton = UITableViewRowAction(style: .default, title: "Edit"){
            (action, indexPath) in
            updateAction(tasks: etask, indexPath: indexPath)
    }
        
    func updateAction(tasks: Task, indexPath: IndexPath){
            let alert = UIAlertController(title: "Update", message: "Update a task", preferredStyle: .alert)
            let _saveAction = UIAlertAction(title: "Save", style: .default) {(action) in
                alert.addTextField()
                guard let textField = alert.textFields?.first else{
                    return
                }
               
                if let textEdited = textField.text{
                    if textEdited.count == 0{
                        return
                    }
                    etask.name = textEdited
                    
                    let encoder = JSONEncoder()
                    if let taskData = try? encoder.encode(self.tasks){
                        self.store.set(taskData, forKey:"tasks" )
                    }
                    self.store.synchronize()
                    self.tableView?.reloadRows(at: [indexPath], with: .automatic)
                }else{
                    return
                }
            }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        alert.addTextField()
       
        alert.addAction(_saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
        
        
        
     }
     
     let deleteButton = UITableViewRowAction(style: .default, title: "Delete"){
     (action, indexPath)in
        
            self.tasks.remove(at: indexPath.row)
            let encoder = JSONEncoder()
            if let taskData = try? encoder.encode(self.tasks){
                self.store.set(taskData, forKey:"tasks")
            }

            self.store.synchronize()
            tableView.reloadData()
}
     deleteButton.backgroundColor = UIColor.red
     editButton.backgroundColor = UIColor.green
        return[deleteButton, editButton]
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    
 //Displaying the check or checkbox. User can mark a task as completed with a checkmark
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let checkedImage = UIImage(named: "checkBoxFilled")! as UIImage
       let uncheckedImage = UIImage(named: "CheckBoxOutLINE")! as UIImage
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskCell
        cell.tasknameLabel.text = tasks[indexPath.row].name
       
        if tasks[indexPath.row].checked {
            cell.checkBoxOutlet.setBackgroundImage(checkedImage,for: UIControl.State.normal)
        } else{
            if tasks[indexPath.row].checked == false {
                cell.checkBoxOutlet.setBackgroundImage(uncheckedImage, for: UIControl.State.normal)
            }
       }
        cell.delegate = self
        cell.indexP = indexPath.row
        cell.tasks = tasks
        return cell
    }
    
    override  func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let vc = segue.destination as! AddTaskController
        vc.delegate = self
    }
    //adding task into User Defaults
    
    func addTask(name: String) {
        tasks.append(Task(name: name))
        let encoder = JSONEncoder()
        if let taskData = try? encoder.encode(self.tasks){
        self.store.set(taskData, forKey:"tasks")
        }
        tableView.reloadData()
    }
}


