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
        //set datepicker timezone
        note.text = " Log your mood"
    }
    
    
    @IBAction func save(sender: AnyObject) {
        
                dismissViewControllerAnimated(true, completion: {
                    
                    print("timeStamp: \(self.datePicker.date)")
                    let nowDate = self.datePicker.date
                    let fireDate = nowDate.dateByAddingTimeInterval( nowDate.timeIntervalSinceReferenceDate + 60.0)
                    
                    
                    let notification = UILocalNotification()
                    notification.fireDate = fireDate
                    let dict:NSDictionary = ["uid": "timeToLogMood" ,"UUID":NSUUID().UUIDString]
                    notification.userInfo = dict as! [String : String]
                    notification.alertTitle = "Time to Log Mood"
                    notification.alertBody = self.note.text
                    notification.alertAction = "swipe here"
                    notification.timeZone = NSTimeZone.defaultTimeZone()
                    notification.applicationIconBadgeNumber = UIApplication.sharedApplication().applicationIconBadgeNumber + 1
                    notification.repeatInterval = NSCalendarUnit.Day
                    notification.soundName = UILocalNotificationDefaultSoundName
                    
                    
                    UIApplication.sharedApplication().scheduleLocalNotification(notification)
                    
                    print(UIApplication.sharedApplication().scheduledLocalNotifications!.count)
                    

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

