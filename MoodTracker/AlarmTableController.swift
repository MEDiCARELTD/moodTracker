
//
//  Notification.swift
//  MoodTracker
//
//  Created by App Camp on 05/08/2016.
//  Copyright © 2016 Daniel. All rights reserved.
//

import UIKit


class AlarmTableController: UITableViewController {
    
    let app:UIApplication = UIApplication.sharedApplication()
    var listOfEvents = [UILocalNotification]()
    
    
    
    override func viewWillAppear(animated: Bool) {
        
        print("\n\n\n \((UIApplication.sharedApplication().scheduledLocalNotifications)?.count))")
       listOfEvents.removeAll()
        for event in app.scheduledLocalNotifications! {
            let notification = event as UILocalNotification
            listOfEvents.append(notification)
        }
        
       
    }
    override func viewDidAppear(animated: Bool) {
         tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
            }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfEvents.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! NotificationCell
        
        let alarm = listOfEvents[indexPath.row]
        
        print(alarm.fireDate)
        cell.time.text = "Time: \(alarm.fireDate!.toShortTimeString())"
        cell.note.text = alarm.alertBody
        
        return cell
        
    }
    
   
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        
        if editingStyle == .Delete
        {
            
            listOfEvents.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
            
            for alarm in listOfEvents{
                
                let notificationToBeDeleted = (listOfEvents[indexPath.row].userInfo as! [String: AnyObject])["UUID"] as! String
                let notificaitonInList = (alarm.userInfo! as! [String:AnyObject])["UUID"]! as! String
                
                if notificationToBeDeleted == notificaitonInList  {
                    
                    print(notificationToBeDeleted)
                    print( notificaitonInList)
                    app.cancelLocalNotification(alarm)
                    print("notification cancelled")
                }
            }
            
        }
        
        
        
    }
    
}


class NotificationCell: UITableViewCell {
    
    
    @IBOutlet var note: UILabel!
    @IBOutlet var time: UILabel!
    
    
    
}

