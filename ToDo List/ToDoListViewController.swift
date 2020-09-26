//
//  ViewController.swift
//  ToDo List
//
//  Created by Manogya Acharya on 9/26/20.
//

import UIKit

class ToDoListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var toDoArray = ["Learn Swift", "Build Apps", "Take A Trip", "Drive Slow Homie"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "ShowDetail" {
            let destination = segue.destination as! ToDoDetailTableViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            destination.toDoItem = toDoArray[selectedIndexPath.row]
        }
    }
    
    @IBAction func unwindFromDetail(segue: UIStoryboardSegue){
        let source = segue.source as! ToDoDetailTableViewController
        if let selectedIndexPath = tableView.indexPathForSelectedRow{
            toDoArray[selectedIndexPath.row] = source.toDoItem
            tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
        }
        else{
            if let selectedIndexPath = tableView.indexPathForSelectedRow{
                tableView.deselectRow(at: selectedIndexPath, animated: true)
            }
            else{
                let newIndexPath = IndexPath(row: toDoArray.count, section: 0)
                toDoArray.append(source.toDoItem)
                tableView.insertRows(at: [newIndexPath], with: .bottom)
                tableView.scrollToRow(at: newIndexPath, at: .bottom, animated: true)
            }
        }
    }
    
}

extension ToDoListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("number of rows was called \(toDoArray.count)")
        return toDoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("cellforRowAt was called for \(indexPath.row) which is the cell containing \(toDoArray[indexPath.row])")
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = toDoArray[indexPath.row]
        return cell
    }
    
    
}
