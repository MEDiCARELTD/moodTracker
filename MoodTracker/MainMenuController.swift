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
    }
    
    
}
