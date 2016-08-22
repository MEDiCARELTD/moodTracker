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
        if notes != "Type some text here to remember how you mood is. Try to rememer what happened before and why this made you feel this way." {
            notes = self.noteTextView.text
        } else {
            notes = ""
        }
        
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
            self.dismissViewControllerAnimated(true, completion: nil)
        }else{
            self.alert.showWarning("Your mood is low", subTitle: "Do you want to talk to someone?", duration: 2)
            
        }
        
    }
    
    let notificationCenter = NSNotificationCenter()
    //// Override functions /////
    override func viewDidLoad(){
    
        super.viewDidLoad()
        print(rootRef)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LogMoodController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LogMoodController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        
        alert = SCLAlertView(appearance: appearance)
        
        // setting up the textView
        noteTextView.text = "Type some text here to remember how you mood is. Try to rememer what happened before and why this made you feel this way."
        noteTextView.textColor = UIColor.lightGrayColor()
    }
    
    
    func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            if view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
            else {
                
            }
            textViewDidBeginEditing(noteTextView)
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            if view.frame.origin.y != 0 {
                self.view.frame.origin.y += keyboardSize.height
            }
            else {
                
            }
            textViewDidEndEditing(noteTextView)
        }
    }
    func textViewDidBeginEditing(textView: UITextView) {
        if textView.textColor == UIColor.lightGrayColor() {
            textView.text = ""
            textView.textColor = UIColor.redColor()
        }
    }
    func textViewDidEndEditing(textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Type some text here to remember how you mood is. Try to rememer what happened before and why this made you feel this way."
            textView.textColor = UIColor.lightGrayColor()
        }
    }
}

