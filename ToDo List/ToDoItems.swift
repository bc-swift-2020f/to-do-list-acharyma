//
//  ToDoItems.swift
//  ToDo List
//
//  Created by Manogya Acharya on 10/3/20.
//

import Foundation
import UserNotifications

class ToDoItems{
    var itemsArray: [ToDoItem] = []
    
    func saveData(){
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let documentURL = directoryURL.appendingPathComponent("todos").appendingPathExtension("json")
        let jsonEncoder = JSONEncoder()
        let data = try? jsonEncoder.encode(itemsArray)
        
        do{
            try data?.write(to: documentURL, options: .noFileProtection)
        }
        catch{
            print("ERROR!")
        }
        setNotifications()
    }
    
    func loadData(completed: @escaping ()->()){
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let documentURL = directoryURL.appendingPathComponent("todos").appendingPathExtension("json")

        guard let data = try? Data(contentsOf: documentURL) else {return}
        let jsonDecoder = JSONDecoder()

        do{
            itemsArray = try jsonDecoder.decode(Array<ToDoItem>.self, from: data)
        }
        catch{
            print("error, couldn't load data")
        }
        completed()
    }
    
    func setNotifications(){
        guard itemsArray.count > 0 else{
            return
        }
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()

        for index in 0..<itemsArray.count {
            if itemsArray[index].reminderSet {
                let toDoItem = itemsArray[index]
                itemsArray[index].notificationID = LocalNotificationManager.setCalenderNotification(title: toDoItem.name, subtitle: "", body: toDoItem.notes, badgeNumber: nil, sound: .default, date: toDoItem.date)
            }
        }
    }
    
}
