//
//  DetailController.swift
//  MoodTracker
//
//  Created by App Camp on 04/08/2016.
//  Copyright © 2016 Daniel. All rights reserved.
//

import UIKit

class DetailController: UIViewController{
    
    var moodLog = MoodLog()
    var index = -1
    var graph = UIImage()
   let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    var retrievedData = [MoodLog]()
    let dateFormatter = NSDateFormatter()
    var date = NSDate()
    
    @IBOutlet weak var moodScore: UILabel!
    
    @IBOutlet weak var dateRecorded: UILabel!
    
    
    @IBOutlet weak var notes: UITextView!
    
    @IBOutlet weak var numberOfLogsToday: UILabel!
   
    @IBOutlet weak var totalNumberOfLogs: UILabel!
    
    
    @IBOutlet weak var averageMoodThatDay: UILabel!
    
    @IBOutlet weak var ImageView: UIImageView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        retrievedData = appDelegate.self.accountLogData
        
        //set the mood score
        moodScore.text = "Mood Score: \(String(moodLog.moodScore))"
        
        // set the date of the recording
        
        dateRecorded.text = "date recorded: \(moodLog.getDateAndTime())"
       
        // set the notes taken at that time
        notes.text = moodLog.note
        
        // total number of logs 
        totalNumberOfLogs.text = "total number of logs: \(String(retrievedData.count))"
        
        // find the average mood that day
        var moodLogsSameDay = [MoodLog]()
       
        for element: MoodLog in retrievedData{
            
            
            if element.getDate() ==  moodLog.getDate(){
                moodLogsSameDay.append(element)
            }
        }
        var totalScore = 0
        for element in moodLogsSameDay{
            totalScore += element.moodScore
            print( totalScore)
            
        }
        
        averageMoodThatDay.text = "Average mood that day: \(String(totalScore / moodLogsSameDay.count))"
        
    // number of logs that day 
        numberOfLogsToday.text = "Mood logs that day: \(moodLogsSameDay.count)"
        
     // set the image 
        ImageView = UIImageView(image: graph)
        
        
    }

}