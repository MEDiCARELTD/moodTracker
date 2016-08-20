//
//  dateHandler.swift
//  MoodTracker
//
//  Created by App Camp on 11/08/2016.
//  Copyright © 2016 Daniel. All rights reserved.
//

import Foundation

class DateHandler {
    
    let dateFormatter = NSDateFormatter()
    let date = NSDate()
    
    init(){
        
    }
    
    func getNSDate(timeInterval: NSTimeInterval) -> NSDate{
        return NSDate(timeIntervalSinceReferenceDate: timeInterval)
    }
    
    func getTime(date: NSDate) -> String {
        dateFormatter.dateFormat = "hh-mm"
        return dateFormatter.stringFromDate(date)
    }
    
    func getTime (timeInterval : NSTimeInterval) -> String{
        dateFormatter.dateFormat = "hh-mm"
        return dateFormatter.stringFromDate(NSDate(timeIntervalSinceReferenceDate: timeInterval))
    }
    func getHour (timeInterval: NSTimeInterval) -> Int {
        dateFormatter.dateFormat = "hh"
        let hour = dateFormatter.stringFromDate(NSDate(timeIntervalSinceReferenceDate: timeInterval))
        
        return Int(hour)!

    }
    
    func getMinuets(timeInterval:NSTimeInterval) -> Int {
        dateFormatter.dateFormat = "hh"
        let minuet = dateFormatter.stringFromDate(NSDate(timeIntervalSinceReferenceDate: timeInterval))
    
        return Int(minuet)!
    }
    
}
extension NSDate {
    
    func getYear() -> Int {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "YYYY"
        let year = dateFormatter.stringFromDate(self)
        
        return Int(year)!
    }
    func getMonth() -> Int {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM"
        let month = dateFormatter.stringFromDate(self)
        
        return Int(month)!
    }
    func getDay()-> String{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let day = dateFormatter.stringFromDate(self)
        
        return "Repeat every: \(String(day))"

    }
    
    func getTime() -> String{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "hh: mm a"
        let time = dateFormatter.stringFromDate(self)
        
        return time
    }
    func getHour() -> Int {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "hh"
        let time = dateFormatter.stringFromDate(self)
        return Int(time)!
    }
    func getMinuet() -> Int {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "mm"
        let time = dateFormatter.stringFromDate(self)
        return Int(time)!

    }
    
   
}

