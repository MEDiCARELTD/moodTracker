//
//  EmergencyController.swift
//  MoodTracker
//
//  Created by App Camp on 18/08/2016.
//  Copyright © 2016 Daniel. All rights reserved.
//

import UIKit

class EmergencyController: UITableViewController{
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.19, green:0.53, blue:0.96, alpha:1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.titleView?.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.19, green:0.53, blue:0.96, alpha:1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.titleView?.tintColor = UIColor.whiteColor()
        
    }
    @IBAction func callLifeline(sender: AnyObject) {
        print("Lifeline Pressed")
        let phoneNumber = "08088088000"
        
        if let phoneCallURL = NSURL(string: "tel:\(phoneNumber)") {
            let application = UIApplication.sharedApplication()
            if application.canOpenURL(phoneCallURL) {
                application.openURL(phoneCallURL)
            }
            else{
                UIApplication.sharedApplication().openURL(NSURL(string: "http://www.lifelinehelpline.info")!)
                print("failed")
            }
        }
    }
    @IBAction func callSamaritans(sender: AnyObject) {
        print("Samaritans Pressed")
        
        let phoneNumber = "116123"
        
        if let phoneCallURL = NSURL(string: "tel:\(phoneNumber)") {
            let application = UIApplication.sharedApplication()
            if application.canOpenURL(phoneCallURL) {
                application.openURL(phoneCallURL)
            }
            else{
                UIApplication.sharedApplication().openURL(NSURL(string: "http://www.samaritans.org/how-we-can-help-you/contact-us?gclid=CjwKEAjwudW9BRDcrd30kovf8GkSJAB3hTxF3hp2pgdVhmTcYtu6eQQRvB6K5xiCjyI3wkSFwFKItxoCKnnw_wcB")!)
                
            }
        }
    }
    
    
    @IBAction func donePressed(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
