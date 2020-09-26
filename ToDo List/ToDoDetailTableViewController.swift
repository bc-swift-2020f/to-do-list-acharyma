//
//  ToDoDetailTableViewController.swift
//  ToDo List
//
//  Created by Manogya Acharya on 9/26/20.
//

import UIKit

class ToDoDetailTableViewController: UITableViewController {
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var noteView: UITextView!
    
    var toDoItem: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if toDoItem == nil{
            toDoItem = ""
        }
        nameField.text = toDoItem

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        toDoItem = nameField.text
    }

    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        let isPresentingInAdMode = presentingViewController is UINavigationController
        
        if isPresentingInAdMode{
            dismiss(animated: true, completion: nil)
        }
        else{
            navigationController?.popViewController(animated: true)
        }
    }
    
    
    
}
