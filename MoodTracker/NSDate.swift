//
//  NSDate.swift
//  MoodTracker
//
//  Created by App Camp on 19/08/2016.
//  Copyright © 2016 Daniel. All rights reserved.
//

import Foundation


extension NSDate
{
    func hour() -> Int
    {
        //Get Hour
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Hour, fromDate: self)
        let hour = components.hour
        
        //Return Hour
        return hour
    }
    
    func year() -> Int
    {
        //Get Hour
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Year, fromDate: self)
        let year = components.year
        
        //Return Hour
        return year
    }
    
    func month() -> Int
    {
        //Get Hour
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Month, fromDate: self)
        let month = components.month
        
        //Return Hour
        return month
    }
    
    func day() -> Int
    {
        //Get Hour
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Day, fromDate: self)
        let day = components.day
        
        //Return Hour
        return day
    }
    
    
    func minute() -> Int
    {
        //Get Minute
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Minute, fromDate: self)
        let minute = components.minute
        
        //Return Minute
        return minute
    }
    
    func toShortTimeString() -> String
    {
        //Get Short Time String
        let formatter = NSDateFormatter()
        formatter.locale =  NSLocale.currentLocale()
        formatter.timeStyle = .ShortStyle
        let timeString = formatter.stringFromDate(self)
        
        //Return Short Time String
        return timeString
    }
    
    
    
    func isBetweeen(date date1: NSDate, andDate date2: NSDate) -> Bool {
        return date1.compare(self) == self.compare(date2)
    }
    
}