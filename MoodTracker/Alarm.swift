//
//  Alarm.swift
//  MoodTracker
//
//  Created by App Camp on 09/08/2016.
//  Copyright © 2016 Daniel. All rights reserved.
//

import Foundation
import Firebase

class Alarm {
    var note = ""
    var time = ""
   
    
    init(note: String, time: String){
        
        self.note = note
        self.time  = time
        
    }
    
    init (){
        
    }
        
}
