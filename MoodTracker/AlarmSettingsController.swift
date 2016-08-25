//
//  AlarmSettingsContoller.swift
//  MoodTracker
//
//  Created by App Camp on 06/08/2016.
//  Copyright © 2016 Daniel. All rights reserved.
//

import UIKit


class AlarmSettingsController: UITableViewController {
    
    @IBOutlet weak var note: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    let dateFormatter = NSDateFormatter()
    var alarmID: String!
    var selectedTime =  NSDate()
    
    //Shake me component
    let shake = ShakeMe()
    
    
    //alarm components
    var newAlarm = Alarm()
    
    
    
    override func viewDidLoad() {
                note.text = " Log your mood"
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.19, green:0.53, blue:0.96, alpha:1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.titleView?.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.19, green:0.53, blue:0.96, alpha:1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.titleView?.tintColor = UIColor.whiteColor()
    }
    
    
    @IBAction func save(sender: AnyObject) {
        
        print("datePicker: \(self.datePicker.date.toShortTimeString())")
        let intervalBetweenNowAndDatePicker = self.datePicker.date.timeIntervalSinceNow
        var fireDate: NSDate
        
        if intervalBetweenNowAndDatePicker < 0 {
            let addDayInterval =  Double(60*60*24)
            fireDate = (NSDate().dateByAddingTimeInterval((intervalBetweenNowAndDatePicker * -1) + addDayInterval ))
            
        } else {
            fireDate = (NSDate().dateByAddingTimeInterval(intervalBetweenNowAndDatePicker))
        }
        
        print("fireDate \(fireDate)")
        
        let notification = UILocalNotification()
        notification.fireDate = fireDate
        let dict:NSDictionary = ["uid": "timeToLogMood" ,"UUID":NSUUID().UUIDString]
        notification.userInfo = dict as! [String : String]
        notification.alertTitle = "Time to Log Mood"
        notification.alertBody = self.note.text
        notification.alertAction = "swipe here"
        notification.timeZone = NSTimeZone.defaultTimeZone()
        notification.repeatInterval = NSCalendarUnit.Day
        notification.soundName = UILocalNotificationDefaultSoundName
        
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        
        print(UIApplication.sharedApplication().scheduledLocalNotifications!.count)
                dismissViewControllerAnimated(true, completion: {
        })
        
    }
    
    @IBAction func cancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: {

        })
    }
    
    
        @IBAction func clearNotifications(sender: AnyObject) {
            UIApplication.sharedApplication().cancelAllLocalNotifications()
            print((UIApplication.sharedApplication().scheduledLocalNotifications))
        }
  
    
   
}

