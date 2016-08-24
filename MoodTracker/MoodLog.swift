//
//  MoodLog.swift
//  MoodTracker
//
//  Created by App Camp on 27/07/2016.
//  Copyright © 2016 Daniel. All rights reserved.
//

import Foundation

class MoodLog{
    
    let dateFormatter = NSDateFormatter()

    var dateTaken: NSTimeInterval! = -1
    var moodScore: Int! = -1
    var note:String = "N/A"
    var logKey: String = "N/A"
    
    
    init(dateTaken: NSTimeInterval!, moodScore: Int!, note: String!, logKey: String!){
        self.dateTaken = dateTaken
        self.moodScore = moodScore
        self.note = note
        self.logKey = logKey
    }
    
    init(){
        
    }
    
    func getNSCalendar () -> NSDateComponents{
        
        let date = NSDate(timeIntervalSinceReferenceDate: dateTaken)
        
        let calendar = NSCalendar.currentCalendar().components([.Day, .Month, .Year], fromDate: (date))
        
        return calendar
    }
    
    func getDateAndTime() -> String {
        let date = NSDate(timeIntervalSinceReferenceDate: dateTaken)
        dateFormatter.dateFormat = "EEEE/ dd"
        let dayAndDate = dateFormatter.stringFromDate(date)
        dateFormatter.dateFormat = " / MMM hh:mm a "
         let monthAndTime = dateFormatter.stringFromDate(date)
        
        return dayAndDate + daySuffix(date) + monthAndTime
    }
    
    func getDate() -> String {
        let date = NSDate(timeIntervalSinceReferenceDate: dateTaken)
        dateFormatter.dateFormat = "EEEE- dd - MMM"
        return dateFormatter.stringFromDate(date)
    }
    func getFullDateAndTime() -> String {
        let date = NSDate(timeIntervalSinceReferenceDate: dateTaken)
        dateFormatter.dateFormat = "dd - EEEE - MMMM  yyyy HH:mm"
        return dateFormatter.stringFromDate(date)
    }
    func getMonth() -> String{
        let date = NSDate(timeIntervalSinceReferenceDate: dateTaken)
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.stringFromDate(date)
    }
    
    func getDay() -> String {
        
        let date = NSDate(timeIntervalSinceReferenceDate: dateTaken)
                dateFormatter.dateFormat = "EEEE"
        
        return dateFormatter.stringFromDate(date)
        
    }
    func getTimeInterval() -> Double {
        return Double(dateTaken)
    }
    
    func getTime() -> String {
        
        let date = NSDate(timeIntervalSinceReferenceDate: dateTaken)

           dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.stringFromDate(date)
    }
    func getAllData() -> String {
        return "\(self.getFullDateAndTime()) mood score \(self.moodScore) \(self.note)"
    }
    func daySuffix(date: NSDate) -> String {
        let calendar = NSCalendar.currentCalendar()
        let dayOfMonth = calendar.component(.Day, fromDate: date)
        switch dayOfMonth {
        case 1, 21, 31: return "st"
        case 2, 22: return "nd"
        case 3, 23: return "rd"
        default: return "th"
        }
    }
    
    
    
}