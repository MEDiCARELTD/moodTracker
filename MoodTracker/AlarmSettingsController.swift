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
        
        
        let nowDate = selectedTime
        let daysToAdd = 1
        let fireDate = nowDate.dateByAddingTimeInterval( 70) //(60 * 60 * 24 * 1)
        
        
        var notification = UILocalNotification()
        notification.fireDate = NSDate(timeIntervalSinceNow:60)
        let dict:NSDictionary = ["title": "timeToLogMood" ,"UUID":NSUUID().UUIDString]
        notification.userInfo = dict as! [String : String]
        notification.alertTitle = "Time to Log Mood"
        notification.alertBody = note.text
        notification.alertAction = "swipe here"
        notification.timeZone = NSTimeZone.defaultTimeZone()
        //notification.applicationIconBadgeNumber = UIApplication.sharedApplication().applicationIconBadgeNumber + 1
        notification.repeatInterval = NSCalendarUnit.Minute
        notification.soundName = UILocalNotificationDefaultSoundName
        
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        
        print((UIApplication.sharedApplication().scheduledLocalNotifications))
        
    }
        //Working copy//////////////
        //        var localNotfication = UILocalNotification()
        //        localNotfication.fireDate = NSDate(timeIntervalSinceNow:60)
        //        localNotfication.alertBody = "Hello"
        //        localNotfication.timeZone = NSTimeZone.defaultTimeZone()
        //        localNotfication.applicationIconBadgeNumber = UIApplication.sharedApplication().applicationIconBadgeNumber + 1
        //
        //        UIApplication.sharedApplication().scheduleLocalNotification(localNotfication)
        //
        //        print(UIApplication.sharedApplication().scheduledLocalNotifications)
        //
        //    }
        
        @IBAction func datePicker(sender: AnyObject) {
            // datePicker.locale = NSLocale(localeIdentifier: "en_GB_POSIX")
            selectedTime = datePicker.date
            
            print("\n\ndate Picker: \(selectedTime)")
            
        }
        
        
        @IBAction func clearNotifications(sender: AnyObject) {
            UIApplication.sharedApplication().cancelAllLocalNotifications()
            print((UIApplication.sharedApplication().scheduledLocalNotifications))
        }
        
        
        
}

