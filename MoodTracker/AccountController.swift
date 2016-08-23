//
//  AccountController.swift
//  MoodTracker
//
//  Created by App Camp on 23/07/2016.
//  Copyright © 2016 Daniel. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
import SCLAlertView

class AccountController: UIViewController {
    
    
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var password: UILabel!
    
    
    
    //REferences our data base
    var rootRef: FIRDatabaseReference!
    let userID: String = (FIRAuth.auth()?.currentUser?.uid)!
    var retrievedData: [MoodLog] = []
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    
    // Initialize SCLAlertView using custom Appearance
    let appearance = SCLAlertView.SCLAppearance(
        showCloseButton: false
    )
    var clearData = SCLAlertView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clearData = SCLAlertView(appearance: appearance)
        
        
        retrievedData = appDelegate.self.accountLogData
        rootRef = FIRDatabase.database().reference()
        rootRef.child("users")
        
        let userID: String = (FIRAuth.auth()?.currentUser?.uid)!
        rootRef.child("users/\(userID)").observeSingleEventOfType(.Value, withBlock: {
            (snapShot) in
            
            let email = snapShot.value! ["email"] as! String
            
            
            self.email.text = "User Email: \(email)"
            
        })
        
    }
    
    @IBAction func clearData(sender: AnyObject) {
        
        clearData.addButton("Continue", action: {
            action in
            
            print("clear Data")
            self.rootRef.child("users/\(self.userID)/logs").removeValue()
            
            let moodRef = self.rootRef.child("moodLogs")
            for element in self.retrievedData {
                moodRef.child(element.logKey).removeValue()
            }
            self.appDelegate.self.accountLogData.removeAll()
            
            
            let alarmRef = self.rootRef.child("users/\(self.userID)/alarmLogs")
            
            alarmRef.observeEventType(.ChildAdded,withBlock:{ snapshot in
                print(snapshot.key)
                
                self.rootRef.child("alarms\(snapshot.key)").removeValue()
                self.rootRef.child("users/\(self.userID)/alarmLogs\(snapshot.key)").removeValue()
                
            })
        })
        clearData.addButton("Cancel", action: { action in
            return
        })
        
        
        self.clearData.showWarning("Attention", subTitle: "All data will be lost permanently ")
      
        
        
        
    }
    
    
    
    @IBAction func Logout(sender: AnyObject){
        print("logging out")
        if FIRAuth.auth()?.currentUser! != nil{
            
            do{
                try FIRAuth.auth()?.signOut()
                print("user logged out")
                self.performSegueWithIdentifier("logout", sender: self)
                
            } catch let error as NSError{
                
                print(error.localizedDescription)
                print("problem signing out:")
            }
            
        } else {
            print("Error")
        }
        
    }
    
    
}


