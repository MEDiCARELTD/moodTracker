//
//  GraphingTool.swift
//  MoodTracker
//
//  Created by App Camp on 07/08/2016.
//  Copyright © 2016 Daniel. All rights reserved.
//

import Foundation


class GraphingTool {
    
    var dateCalculator = DateCalculator()
    
    func getListOfLogsForToday(retrievedData: [MoodLog])-> [MoodLog]{
        
        // makes sure retrieved data is not empty
        if retrievedData.count <= 0 {
            return [MoodLog]()
        }
        
        let maxIndex = (retrievedData.count - 1)
        print(maxIndex)
        
        var listForDay = [MoodLog]()
        
        for element in retrievedData {
            
            if element.getDate() == dateCalculator.currentDate(){
                print(element.getDate())
                listForDay.append(element)
            }
            
        }
        return listForDay
        
    }
    
    func getListOfLogsForPastWeek(retrievedData: [MoodLog]) -> [MoodLog] {
        
        // makes sure retrieved data is not empty
        if retrievedData.count <= 0 {
            return [MoodLog]()
        }
        
        let maxIndex = retrievedData.count - 1
        
        let finalElement = retrievedData[maxIndex]
        
        let maxTimeInterval = finalElement.getTimeInterval()
        let miniumTimeInterval = maxTimeInterval - 604800
        
        var listForWeek = [MoodLog]()
        
        for element in retrievedData {
            if element.getTimeInterval() <= maxTimeInterval && element.getTimeInterval() >= miniumTimeInterval{
                
                listForWeek.append(element)
            }
            
        }
        return listForWeek
        
        
    }
    func getListOfLogsForPast3Months(retrievedData: [MoodLog]) -> [MoodLog] {
        
        // makes sure retrieved data is not empty
        if retrievedData.count <= 0 {
            return [MoodLog]()
        }
        
        let maxIndex = retrievedData.count - 1
        let finalElement = retrievedData[maxIndex]
        
        var listForPast3Months = [MoodLog]()
        
        let maxTimeInterval = finalElement.getTimeInterval()
        let miniumTimeInterval = maxTimeInterval - 7884000
        
        for element in retrievedData {
            if element.getTimeInterval() <= maxTimeInterval && element.getTimeInterval() >= miniumTimeInterval {
                listForPast3Months.append(element)
            }
        }
        
        return listForPast3Months
        
        
    }
    
    func getlistOfLogsBetweenTwoDates(retrievedData: [MoodLog],date1: NSDate, date2: NSDate) -> [MoodLog]{
        
        var listCustomRange = [MoodLog]()
        
        let interval1 = date1.timeIntervalSinceReferenceDate
        let interval2 = date2.timeIntervalSinceReferenceDate
        
        if interval1 - interval2 < 0{
            for element in retrievedData{
                if element.getTimeInterval() < interval2 && element.getTimeInterval() > interval1{
                    listCustomRange.append(element)
                }
            }
        }else {
            
            for element in retrievedData{
                if element.getTimeInterval() < interval1 && element.getTimeInterval() > interval2{
                    listCustomRange.append(element)
                }
            }
        }
        return listCustomRange
    }
    
    
}

struct DateCalculator{
    
    func currentDate() -> String {
        let date = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEEE- dd - MMM"
        return dateFormatter.stringFromDate(date)
    }
}
