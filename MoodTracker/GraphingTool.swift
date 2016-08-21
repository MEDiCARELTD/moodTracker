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

    
}

struct DateCalculator{
    
    func currentDate() -> String {
        let date = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEEE- dd - MMM"
        return dateFormatter.stringFromDate(date)
    }
}
