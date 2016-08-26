//
//  TestGraph.swift
//  MoodTracker
//
//  Created by App Camp on 07/08/2016.
//  Copyright © 2016 Daniel. All rights reserved.
//

import Foundation
import Firebase

class TestGraph{
    //        //test Months
    //        let test = TestGraph()
    //        test.logMoodOverMonths(rootRef,userID: userID)
    
    //        // test over three Months
    //        let test = TestGraph()
    //        test.logMoodOver3Months(rootRef, userID: userID)
    var logID: String!
    var currentDate: String!
    var notes: String! = " no notes taken"
    var dateFormatter = NSDateFormatter()
    var score: Int!
    var count = 3600.0
    
    
    init(){
        
    }
    
    
    func logMood100(rootRef:FIRDatabaseReference, userID: String){
        var counter = 1
        print("Logging Mood")
        while counter < 100 {
            print("log mood: /\(counter)")
            counter += 1
            let currentTimeInterval: Double = Double(NSDate().timeIntervalSinceReferenceDate)
            
            let currentDate = String(currentTimeInterval + count)
            count += 3600.0
            
            score = random(11)
            notes = "Testing Graph"
            
            // adding a moodLog to table "moodLogs"
            let moodRef = rootRef.child("moodLogs")
            let logKey = moodRef.childByAutoId()
            let logDetails = ["dateTaken": currentDate,"moodScore": score,"notes": notes, "logKey": logKey.key ]
            logKey.setValue(logDetails)
            
            // adding key referencing moodLog to user
            let userRef = rootRef.child("users").child(userID)
            userRef.child("logs").child(logKey.key).setValue("True")
        }
    }
    
    func logMoodOver7days (rootRef:FIRDatabaseReference, userID: String){
        var counter = 1
        print("Logging Mood")
        while counter < 21 {
            print("log mood: /\(counter)")
            counter += 1
            let currentTimeInterval: Double = Double(NSDate().timeIntervalSinceReferenceDate)
            
            let currentDate = String(currentTimeInterval + count)
            count += 17280
            
            score = random(11)
            notes = "Testing Graph"
            
            // adding a moodLog to table "moodLogs"
            let moodRef = rootRef.child("moodLogs")
            let logKey = moodRef.childByAutoId()
            let logDetails = ["dateTaken": currentDate,"moodScore": score,"notes": notes, "logKey": logKey.key ]
            logKey.setValue(logDetails)
            
            // adding key referencing moodLog to user
            let userRef = rootRef.child("users").child(userID)
            userRef.child("logs").child(logKey.key).setValue("True")
        }
    }
    
    
    func logMoodOverMonths(rootRef:FIRDatabaseReference, userID: String){
        var counter = 1
        print("Logging Mood")
        while counter < 50 {
            print("log mood: /\(counter)")
            counter += 1
            let currentTimeInterval: Double = Double(NSDate().timeIntervalSinceReferenceDate)
            
            let currentDate = String(currentTimeInterval + count)
            count += (2.628e+6/5)
            
            score = random(11)
            notes = "Testing Graph"
            
            // adding a moodLog to table "moodLogs"
            let moodRef = rootRef.child("moodLogs")
            let logKey = moodRef.childByAutoId()
            let logDetails = ["dateTaken": currentDate,"moodScore": score,"notes": notes, "logKey": logKey.key ]
            logKey.setValue(logDetails)
            
            // adding key referencing moodLog to user
            let userRef = rootRef.child("users").child(userID)
            userRef.child("logs").child(logKey.key).setValue("True")
        }
    }
    
    func logMoodOver3Months(rootRef:FIRDatabaseReference, userID: String){
        var counter = 1
        print("Logging Mood")
        while counter < 50 {
            print("log mood: /\(counter)")
            counter += 1
            let currentTimeInterval: Double = Double(NSDate().timeIntervalSinceReferenceDate)
            
            let currentDate = String(currentTimeInterval + count)
            count += (2.628e+6/6)
            
            score = random(11)
            notes = "Testing Graph"
            
            // adding a moodLog to table "moodLogs"
            let moodRef = rootRef.child("moodLogs")
            let logKey = moodRef.childByAutoId()
            let logDetails = ["dateTaken": currentDate,"moodScore": score,"notes": notes, "logKey": logKey.key ]
            logKey.setValue(logDetails)
            
            // adding key referencing moodLog to user
            let userRef = rootRef.child("users").child(userID)
            userRef.child("logs").child(logKey.key).setValue("True")
        }

    }

    func random(range: UInt32) -> Int{
        let random = Int(arc4random_uniform(range))
        
        return random
    }
    
    
    
}