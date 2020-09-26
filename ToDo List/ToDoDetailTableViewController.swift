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
    @IBOutlet weak var reminderSwitch: UISwitch!
    @IBOutlet weak var dateLabel: UILabel!
    
    let datePickerIndexPath = IndexPath(row:1, section: 1)
    let notesTextViewIndexPath = IndexPath(row:0, section: 2)
    let notesRowHeight: CGFloat = 200
    let defaultRowHeight: CGFloat = 44

    
    var toDoItem: ToDoItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if toDoItem == nil{
            toDoItem = ToDoItem(name: "", date: Date(), notes: "", reminderSet: false)
        }
        
        updateUserInterface()
    }
    
    func updateUserInterface(){
        nameField.text = toDoItem.name
        datePicker.date = toDoItem.date
        noteView.text = toDoItem.notes
        reminderSwitch.isOn = toDoItem.reminderSet
        
        dateLabel.textColor = (reminderSwitch.isOn ? .black : .gray)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        toDoItem = ToDoItem(name: nameField.text!, date: datePicker.date, notes: noteView.text, reminderSet: reminderSwitch.isOn)
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
    
    
    @IBAction func reminderSwitchChanged(_ sender: UISwitch) {
        dateLabel.textColor = (reminderSwitch.isOn ? .black : .gray)
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}

extension ToDoDetailTableViewController{
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath{
        case datePickerIndexPath:
            return reminderSwitch.isOn ? datePicker.frame.height : 0
        case notesTextViewIndexPath:
            return notesRowHeight
        default:
            return defaultRowHeight
        }
    }
}
