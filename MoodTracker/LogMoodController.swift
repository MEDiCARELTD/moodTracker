//
//  LogMood.swift
//  MoodTracker
//
//  Created by App Camp on 25/07/2016.
//  Copyright © 2016 Daniel. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import SCLAlertView

class LogMoodController: UIViewController {
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var retrievedData: [MoodLog] = []
    var aMoodLog: MoodLog = MoodLog()

    
    lazy var rootRef = FIRDatabase.database().reference()
    var userID: String = (FIRAuth.auth()?.currentUser?.uid)!
    var logID: String!
    var currentDate: String!
    var notes: String! = " no notes taken"
    var dateFormatter = NSDateFormatter()
    var score: Int!
    var alert = SCLAlertView()
    
    @IBOutlet var image: UIImageView!
    @IBOutlet var moodScoreLabel: UILabel!
    @IBOutlet var sliderScore: UISlider!
    @IBOutlet var moodScoreTextField: UITextField!
    @IBOutlet weak var noteTextView: UITextView!
    
    
    
    @IBAction func sliderScore(sender: AnyObject) {
        
        sliderScore.value  = round(sliderScore.value)
        
        print(sliderScore.value)
        switch sliderScore.value {
        case 1:
            moodScoreLabel.text = "Mood score: 1"
            image.image = UIImage(named:"mood-1.png")
        case 2:
            moodScoreLabel.text = "Mood score: 2"
            image.image = UIImage(named:"mood-2.png")
        case 3:
            moodScoreLabel.text = "Mood score: 3"
            image.image = UIImage(named:"mood-3.png")
        case 4:
            moodScoreLabel.text = "Mood score: 4"
            image.image = UIImage(named:"mood-4.png")
        case 5:
            moodScoreLabel.text = "Mood score: 5"
            image.image = UIImage(named:"mood-5.png")
        case 6:
            moodScoreLabel.text = "Mood score: 6"
            image.image = UIImage(named:"mood-6.png")
        case 7:
            moodScoreLabel.text = "Mood score: 7"
            image.image = UIImage(named:"mood-7.png")
        case 8:
            moodScoreLabel.text = "Mood score: 8"
            image.image = UIImage(named:"mood-8.png")
        case 9:
            moodScoreLabel.text = "Mood score: 9"
            image.image = UIImage(named:"mood-9.png")
        case 10:
            moodScoreLabel.text = "Mood score: 10"
            image.image = UIImage(named:"mood-10.png")
            
        default:
            moodScoreLabel.text = "Mood score: 0"
            image.image = UIImage(named:"mood-0.png")
            
        }
    }
    
    // Initialize SCLAlertView using custom Appearance
    let appearance = SCLAlertView.SCLAppearance(
        showCloseButton: false
    )
 
    
    
    @IBAction func logMood(sender: AnyObject)
    {
        print("Logging Mood")
        
        let currentDate = String(NSDate().timeIntervalSinceReferenceDate)
        
        score = Int(self.sliderScore.value)
       
        notes = self.noteTextView.text
        
        // adding a moodLog to table "moodLogs"
        let moodRef = rootRef.child("moodLogs")
        let logKey = moodRef.childByAutoId()
        let logDetails = ["dateTaken": currentDate,"moodScore": score,"notes": notes, "logKey": logKey.key ]
        logKey.setValue(logDetails)
        
        // adding key referencing moodLog to user
        let userRef = rootRef.child("users").child(userID)
        userRef.child("logs").child(logKey.key).setValue("True")
        
        if score > 3 {
            self.alert.showSuccess("Mood Logged!", subTitle: " ",duration: 2)
            
        }else{
            self.alert.showWarning("Your mood is low", subTitle: "Do you want to talk to someone?", duration: 2)
            performSegueWithIdentifier("EmergencyID", sender: nil)
            
        }
        
    }
    
    let notificationCenter = NSNotificationCenter()
    //// Override functions /////
    override func viewDidLoad(){
        super.viewDidLoad()
    
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
    
        
        print(rootRef)
        
        var dateTaken:NSTimeInterval!
        var moodScore: Int!
        
        alert = SCLAlertView(appearance: appearance)
        
        rootRef = FIRDatabase.database().reference()
        rootRef.child("Users")
        
        let userID: String = (FIRAuth.auth()?.currentUser?.uid)!
        
        let userRef = rootRef.child("users/\(userID)/logs")
        
        
        
//                        // test over three Months
//                        let test = TestGraph()
//                        test.logMoodOver3Months(rootRef, userID: userID)
        
        
        userRef.observeEventType(.ChildAdded,withBlock:{ snapshot in
            
            // For each key in the snapshot, which will be the mood logs id
            var logKey = snapshot.key
            
            //Send another request to firebase to get the details of that mood log
            let moodRef = self.rootRef.child("moodLogs/\(logKey)")
            moodRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
                
                dateTaken = Double((snapshot.value!.objectForKey("dateTaken")!) as! String)
                moodScore = snapshot.value!.objectForKey("moodScore")! as! Int
                self.notes = snapshot.value!.objectForKey("notes")! as! String
                logKey = snapshot.value!.objectForKey("logKey")! as! String
                
                self.aMoodLog = MoodLog(dateTaken: dateTaken!, moodScore: moodScore!, note: self.notes!, logKey: logKey)
                self.retrievedData.append(self.aMoodLog)
                self.appDelegate.self.accountLogData = self.retrievedData
                
                //snapshot will be the mood log object
                // so do something with that in here like storing them in arrays
            })
        })
        
        
        rootRef.child("users/\(userID)/email").setValue(FIRAuth.auth()?.currentUser?.email)

    }
    
  }

