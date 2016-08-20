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
        
    }
   
    
    @IBAction func save(sender: AnyObject) {
        
        
        
        dateFormatter.timeStyle = .ShortStyle
        let selectedDate = datePicker.date
        let date = NSDate()
        let c = NSDateComponents()
        
        c.year = date.year()
        c.month = date.month()
        c.day = date.day()
        c.hour = selectedDate.hour()
        c.minute = selectedDate.minute()
        c.second = 0
        
        let finalFireDate = NSCalendar(identifier: NSCalendarIdentifierGregorian)?.dateFromComponents(c)

        let notification = UILocalNotification()
        notification.repeatInterval = NSCalendarUnit.Minute
        notification.alertTitle = "Time to Log Mood"
        notification.alertBody = note.text
        notification.alertAction = "swipe here"
        notification.fireDate = finalFireDate
        
        var NSDate = ()
        now = NSDate()
        var daysToAdd = 1
        var newDate1 = now.dateByAddingTimeInterval(60 * 60 * 24 * daysToAdd)

        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        
        print((UIApplication.sharedApplication().scheduledLocalNotifications))
        
       // self.dismissViewControllerAnimated(true, completion: {})
        
    }
    

    @IBAction func datePicker(sender: AnyObject) {
       // datePicker.locale = NSLocale(localeIdentifier: "en_GB_POSIX")
        selectedTime = datePicker.date
        
        print("date Picker: \(selectedTime)")
        
    }
    
    
    @IBAction func clearNotifications(sender: AnyObject) {
        UIApplication.sharedApplication().cancelAllLocalNotifications()
        print((UIApplication.sharedApplication().scheduledLocalNotifications))
    }
    
    
    
}

