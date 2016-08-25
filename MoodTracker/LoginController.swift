//
//  ViewController.swift
//  MoodTracker
//
//  Created by App Camp on 22/07/2016.
//  Copyright © 2016 Daniel. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import SCLAlertView


class LoginController: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate {
    
    
    @IBOutlet  var email: UITextField!
    @IBOutlet  var password: UITextField!
    
    
    
    var errorHandler = ErrorHandler()
    var userID: String!
    var alert = SCLAlertView()
    let shakeMe = ShakeMe()
    //Database References
    var RootRef: FIRDatabaseReference!
    
    // Initialize SCLAlertView using custom Appearance
    let appearance = SCLAlertView.SCLAppearance(
        showCloseButton: false
    )
    override func viewWillAppear(animated: Bool) {
        
        if FIRAuth.auth()?.currentUser != nil {
            
            print("User already signed in")
            self.performSegueWithIdentifier("MainMenu", sender: nil)
            
        }
    }
        override func viewDidLoad() {
            super.viewDidLoad()
            
            alert = SCLAlertView(appearance: appearance)
            
            RootRef = FIRDatabase.database().reference()
            //FIRDatabase.database().persistenceEnabled = true
            GIDSignIn.sharedInstance().clientID = FIRApp.defaultApp()?.options.clientID
            GIDSignIn.sharedInstance().delegate = self
            GIDSignIn.sharedInstance().uiDelegate = self
        }
        
        
        
        /// Sign in with email and password
        @IBAction func createAccount(){
            print("attempting to log in with email and password")
            
            FIRAuth.auth()?.signInWithEmail(email.text!, password: password.text!, completion: {
                
                
                user,error  in
                
                self.shakeMe.shakeMeIfEmpty(self.password)
                self.shakeMe.shakeMeIfEmpty(self.email)
                if error != nil{
                    self.errorHandler.searchError(error!)
                }
                else {
                    self.alert.showSuccess("Success!", subTitle: "You have successfully logged in ",duration: 3)
                    self.performSegueWithIdentifier("MainMenu", sender: nil)
                }
                
            })
            
            
            
        }
        
        
        // Sign in with google
        func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!, withError error: NSError!)  {
            print("google sign in button pressed")
            
            if let error = error {
                print(error.localizedDescription)
                
            }
            let authentication = user.authentication
            let credential = FIRGoogleAuthProvider.credentialWithIDToken(authentication.idToken, accessToken: authentication.accessToken)
            
            FIRAuth.auth()?.signInWithCredential(credential, completion: {(user, error) in
                
                if error != nil{
                    self.errorHandler.searchError(error!)
                }
                else{
                    
                    self.alert.showSuccess("Congratulations", subTitle: "You have made a Firebase account!",duration: 3)
                    
                    let userEmail: String = self.email.text!
                    print("User Created")
                    self.RootRef.child("users").child(user!.uid).setValue(["email": userEmail])
                    
                    print("user logged in with google account")
                    
                    
                    self.performSegueWithIdentifier("MainMenu", sender: nil)
                    
                }
                
            })
            
            
        }
        
        
        
        @IBAction func googleSignIn(sender: AnyObject) {
            print("Google sign in pressed")
        }
        
        
        //////////////// Override functions //////////////////
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        
        
        
        
    }
    

