//
//  RedeemPassword.swift
//  MoodTracker
//
//  Created by App Camp on 08/08/2016.
//  Copyright © 2016 Daniel. All rights reserved.
//

import UIKit
import Firebase
import SCLAlertView

class RedeemPassword: UIViewController {
    
    
    @IBOutlet var email: UITextField!
    @IBOutlet var confirmEmail: UITextField!
    
     var RootRef: FIRDatabaseReference!
    var errorHandler = ErrorHandler()
    var alert = SCLAlertView()
    let shakeMe = ShakeMe()
    // Initialize SCLAlertView using custom Appearance
    let appearance = SCLAlertView.SCLAppearance(
        showCloseButton: false
    )
    
    @IBAction func sendRequest(sender: AnyObject) {
        
        
        if email.text == confirmEmail.text {
            
            FIRAuth.auth()?.sendPasswordResetWithEmail(email.text!, completion: { (error) in
            
                self.shakeMe.shakeMeIfEmpty(self.confirmEmail)
                self.shakeMe.shakeMeIfEmpty(self.email)
                
                if self.email.text != self.confirmEmail.text{
                    self.alert.showError("Email", subTitle: "They do not match")
                }
                else if error != nil {
                    self.errorHandler.searchError(error!)
                }
                else {
                    
                    self.alert.showSuccess("Email sent!", subTitle: "",duration: 1)
                    self.navigationController?.popViewControllerAnimated(true)
                }
               
                
            })
            
            
           
        }else{
            self.alert.showError("Email", subTitle: "They do not match",duration: 2)
            }
        
    }
    @IBAction func dismissKeyboard(sender: AnyObject){
        
        email.resignFirstResponder()
        confirmEmail.resignFirstResponder()
    
    }
    
    override func viewDidLoad() {
         alert = SCLAlertView(appearance: appearance) 
    }
    
}
