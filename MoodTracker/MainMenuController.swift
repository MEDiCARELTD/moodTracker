//
//  FirebaseBrain.swift
//  MoodTracker
//
//  Created by App Camp on 27/07/2016.
//  Copyright © 2016 Daniel. All rights reserved.
//

import Firebase
import UIKit

class MainMenuController: UIViewController {
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var rootRef: FIRDatabaseReference!
    var userID: String = (FIRAuth.auth()?.currentUser?.uid)!
    var userAlarms = [Alarm]()
    var retrievedData: [MoodLog] = []
    var aMoodLog: MoodLog = MoodLog()
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.19, green:0.53, blue:0.96, alpha:1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.titleView?.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.19, green:0.53, blue:0.96, alpha:1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.titleView?.tintColor = UIColor.whiteColor()
        
        let attrs = [
            NSForegroundColorAttributeName : UIColor.whiteColor(),]
        self.navigationController?.navigationBar.titleTextAttributes = attrs
        
        var dateTaken:NSTimeInterval!
        var moodScore: Int!
        var notes: String!
        
        print("Main Menu: Loading in notes")
        
        
        rootRef = FIRDatabase.database().reference()
        rootRef.child("Users")
        
        let userID: String = (FIRAuth.auth()?.currentUser?.uid)!
        
        let userRef = rootRef.child("users/\(userID)/logs")
        
        
        //        //test Months
        //        let test = TestGraph()
        //        test.logMoodOverMonths(rootRef,userID: userID)
        
        //                // test over three Months
        //                let test = TestGraph()
        //                test.logMoodOver3Months(rootRef, userID: userID)
        
        
        userRef.observeEventType(.ChildAdded,withBlock:{ snapshot in
            
            // For each key in the snapshot, which will be the mood logs id
            var logKey = snapshot.key
            
            //Send another request to firebase to get the details of that mood log
            let moodRef = self.rootRef.child("moodLogs/\(logKey)")
            moodRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
                
                dateTaken = Double((snapshot.value!.objectForKey("dateTaken")!) as! String)
                moodScore = snapshot.value!.objectForKey("moodScore")! as! Int
                notes = snapshot.value!.objectForKey("notes")! as! String
                logKey = snapshot.value!.objectForKey("logKey")! as! String
                
                self.aMoodLog = MoodLog(dateTaken: dateTaken!, moodScore: moodScore!, note: notes!, logKey: logKey)
                self.retrievedData.append(self.aMoodLog)
                self.appDelegate.self.accountLogData = self.retrievedData
                
                //snapshot will be the mood log object
                // so do something with that in here like storing them in arrays
            })
        })
        
        
        rootRef.child("users/\(userID)/email").setValue(FIRAuth.auth()?.currentUser?.email)
        
        self.appDelegate.self.userAlarms  = self.userAlarms
        
        
        
    }
    
    
}
