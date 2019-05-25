//
//  AddTaskController.swift
//  todoApp


import UIKit

protocol AddTask{
    func addTask(name: String)
}

class AddTaskController: UIViewController {

    @IBOutlet weak var taskNameOutlet: UITextField!
   
    var delegate: AddTask?
    
    
    @IBAction func addAction(_ sender: Any) {
        if  taskNameOutlet.text != "" {
            delegate?.addTask(name: taskNameOutlet.text!)
            navigationController?.popViewController(animated: true)
            }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

