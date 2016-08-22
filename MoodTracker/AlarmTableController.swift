
//
//  Notification.swift
//  MoodTracker
//
//  Created by App Camp on 05/08/2016.
//  Copyright © 2016 Daniel. All rights reserved.
//

import UIKit


class AlarmTableController: UITableViewController {
    
    var userAlarms: [Alarm] = []
    
    
    override func viewWillAppear(animated: Bool) {
        print("\n\n\n")
        print((UIApplication.sharedApplication().scheduledLocalNotifications)?.count)

    }
    override func viewDidLoad() {
            }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userAlarms.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! NotificationCell
        
        let alarm = userAlarms[indexPath.row]
        
        cell.time.text = "Time: \(alarm.time)"
        cell.note.text = alarm.note
        
        
        return cell
        
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        
        if editingStyle == .Delete {
            
        }
        
        userAlarms.removeAtIndex(indexPath.row)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        print("\n\n scheduled notifications: \(UIApplication.sharedApplication().scheduledLocalNotifications?.count)")
        
        
    }
    
}


class NotificationCell: UITableViewCell {
    
    
    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var note: UITextView!
  
    
}

