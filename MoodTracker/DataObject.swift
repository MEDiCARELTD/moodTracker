//
//  DataObject.swift
//  MoodTracker
//
//  Created by App Camp on 15/08/2016.
//  Copyright © 2016 Daniel. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class DataObject{
    
    lazy var rootRef = FIRDatabase.database().reference()
    var userID: String = (FIRAuth.auth()?.currentUser?.uid)!
    var TipsForStressID: String!
    
    
    var title = String()
    var image = String()
    var info = String()
    var link = String()
    var key = String()
    
    
    init(title: String, image: String, info:String, link: String, key: String) {
        
        self.title = title
        self.image = image
        self.info = info
        self.link = link
        self.key = key
    }
    init(){
        
    }
    
    func createAndSyncToFirebase(){
        print("Creating and syncing object to firebase")
        
        let tipsForStressRef = rootRef.child("tipsForStress")
        let keyRef = tipsForStressRef.child(key)
        let bodyDetails = ["title": title, "image": image,"info": info,"link": link,"key": key]
        
        keyRef.setValue(bodyDetails)
        
        
    }
  
    func syncWithFirebase() {
        
        print("syncing TipsForStress to Firebase ")
        
        let tipsForStressRef = rootRef.child("tipsForStress")
        let body = ["title": title, "image": image, "info": info, "key": key ]
        tipsForStressRef.child(key).setValue(body)
    
    }
    
    func removeFromFirebase(){
        print("Removing tipForStress from firebasealarm: \(key)")
        
                let tipsForStress = rootRef.child("tipsForStress")
        tipsForStress.child(key).removeValue()
        
        
    }

    
}