//
//  Notifications.swift
//  MoodTracker
//
//  Created by App Camp on 19/08/2016.
//  Copyright © 2016 Daniel. All rights reserved.
//

import UIKit

class Notifications : UIViewController {
    
    var dateToday = NSDate()
    
    var chosenDate: NSDate!
    var datePicker: UIDatePicker!
    let dateFormatter = NSDateFormatter()

    
    @IBOutlet var date: UITextField!
    
    @IBAction func showDatePicker(sender: AnyObject) {
        
        self.datePicker = UIDatePicker(frame:CGRectMake(0, 0, self.view.frame.size.width, 216))
        self.datePicker.backgroundColor = UIColor.whiteColor()
        self.datePicker.datePickerMode = UIDatePickerMode.Time
        date.inputView = self.datePicker
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .Default
        toolBar.translucent = true
        toolBar.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .Plain, target: self, action: #selector(Notifications.doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: #selector(Notifications.cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.userInteractionEnabled = true
        date.inputAccessoryView = toolBar
        
        
    }
    
    
    override func viewDidLoad() {
         super.viewDidLoad()

        
    }
    
    
    @IBAction func setNotification(sender: AnyObject) {
        
   
        
        dateFormatter.timeStyle = .ShortStyle
       
  
        
        let c = NSDateComponents()
        
        c.year = dateToday.year()
        c.month = dateToday.month()
        c.day = dateToday.day()
        c.hour = chosenDate.hour()
        c.minute = chosenDate.minute()
        c.second = 0
        
        let finalFireDate = NSCalendar(identifier: NSCalendarIdentifierGregorian)?.dateFromComponents(c)

        let notification = UILocalNotification()
        
        notification.alertTitle = "Hopefully"
        notification.alertAction = "THIS BLOODY WORKS!"
        notification.fireDate = finalFireDate
        notification.alertAction = "open"
        notification.soundName = UILocalNotificationDefaultSoundName
        
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        
        print("Scheduled notifciation: \(UIApplication.sharedApplication().scheduledLocalNotifications)")
        
        
    }
    
    func doneClick() {

        datePicker.locale = NSLocale(localeIdentifier: "en_GB_POSIX")
//        dateFormatter.dateStyle = .ShortStyle
        dateFormatter.timeStyle = .ShortStyle
//        dateFormatter.dateFormat = "dd-MM-yyyy"
//        dateFormatter.locale = NSLocale(localeIdentifier: "en_GB_POSIX")
//        dateFormatter.timeStyle = .NoStyle
        chosenDate = datePicker.date
        
        date.text = dateFormatter.stringFromDate(chosenDate)
        
        date.resignFirstResponder()
    }
    
    
    func cancelClick() {
        date.resignFirstResponder()
    }
    
}
