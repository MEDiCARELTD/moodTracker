//
//  EmergencyController.swift
//  MoodTracker
//
//  Created by App Camp on 18/08/2016.
//  Copyright © 2016 Daniel. All rights reserved.
//

import UIKit

class EmergencyController: UITableViewController{
    
    
    @IBAction func callLifeline(sender: AnyObject) {
        
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
}
