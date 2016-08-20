//
//  Register.swift
//  MoodTracker
//
//  Created by App Camp on 28/07/2016.
//  Copyright © 2016 Daniel. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import SCLAlertView

class RegisterController: UIViewController {
    
    
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var register: UIButton!
    
    var userID: String!
    let shakeMe = ShakeMe()
    
    //Database References
    var RootRef: FIRDatabaseReference!
    var errorHandler = ErrorHandler()
    /*@IBAction func dismissKeyboard(sender: AnyObject){
        email.resignFirstResponder()
        password.resignFirstResponder()
        confirmPassword.resignFirstResponder()
        
    }*/
    
    // Initialize SCLAlertView using custom Appearance
    let appearance = SCLAlertView.SCLAppearance(
        showCloseButton: false
    )
    var alert = SCLAlertView()
    
    override func viewDidLoad() {
        
        alert = SCLAlertView(appearance: appearance)
    }
    
    @IBAction func register(sender: AnyObject) {
        
        FIRAuth.auth()?.createUserWithEmail(email.text!, password: password.text!, completion: {
            
            user,error in
            
            self.shakeMe.shakeMeIfEmpty(self.email)
            self.shakeMe.shakeMeIfEmpty(self.password)
            self.shakeMe.shakeMeIfEmpty(self.confirmPassword)
            
            if self.password.text != self.confirmPassword.text{
                
                self.alert.showError("Check Password", subTitle: " They do not match", duration: 2)
            }
            else if error != nil{
                
                self.errorHandler.searchError(error!)
                
            }else{
                self.alert.showSuccess("Congratulations", subTitle: "You have made a Firebase account!",duration: 2)
                self.performSegueWithIdentifier("MainMenu", sender: nil)
                
            }
        })
    }
}





