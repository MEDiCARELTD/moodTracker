//
//  TipsForStressBody.swift
//  MoodTracker
//
//  Created by App Camp on 16/08/2016.
//  Copyright © 2016 Daniel. All rights reserved.
//

import UIKit
import FirebaseDatabase
class Body {
    lazy var rootRef = FIRDatabase.database().reference()
    
    
    let title1 = "10 Stress Busters "
    let image1 = "check-Your-Mood.png"
    let info1 = "The most unhelpful thing you can do is turn to something unhealthy to help you cope, such as smoking or drinking. Read these top 10 busters to battle stress"
    
    let link1 = "http://www.nhs.uk/conditions/stress-anxiety-depression/pages/reduce-stress.aspx"
    
    let title2 = "lifeline"
    let image2 = "lifeline.png"
    let info2 = " Lifeline is the Northern Ireland crisis response helpline service for people who are experiencing distress or despair. No matter what your age or where you live in Northern Ireland, if you are or someone you know is in distress or despair, Lifeline is here to help."
    
    let link2 = "http://www.lifelinehelpline.info/"
    
    let title3 = "samaritans.png"
    let image3 = ""
    let info3 = "We're here round the clock, 24 hours a day, 365 days a year. If you need a response immediately, it's best to call us on the phone. This number is FREE to call. You don't have to be suicidal to call us. "
    
    let link3 = "http://www.samaritans.org/how-we-can-help-you/contact-us?gclid=Cj0KEQjw88q9BRDB5qLcwLXr7_sBEiQAZsGja_eS4mK1eLBj05LJ_DpJi0nGzhplECfLYUi6VNDzU4QaAhmM8P8HAQ"
    
    let title4 = "Aware"
    let image4 = "aware.png"
    let info4 = "We are the only mental health charity in Northern Ireland working exclusively for those with depression and bipolar disorder. The focus of our work is to educate and provide support to people on the illness of depression."
    let link4 = "https://www.aware-ni.org/"
    
    let title5 = " NHS stop smoking services help you quit"
    let image5 = "NHS-choices.png"
    let info5 = "Local stop smoking services staffed by expert advisers provide a range of proven methods to help you quit. They will give you accurate information and advice and give you professional support during the first few months of stopping smoking. "
    let link5 = "http://www.nhs.uk/Livewell/smoking/Pages/NHS-stop-smoking-adviser.aspx"
    
    func createAndSyncTipsForStressArray(){
        
            
            let cell1 = DataObject(title: title1, image: image1, info: info1, link:link1, key: "1")
            let cell2 = DataObject(title: title2, image: image2, info: info2, link:link2, key: "2")
            let cell3 = DataObject(title: title3, image: image3, info: info3, link:link3, key: "3")
            let cell4 = DataObject(title: title4, image: image4, info: info4, link:link4, key: "4")
            let cell5 = DataObject(title: title5, image: image5, info: info5, link:link5, key: "5")
            
            cell1.createAndSyncToFirebase()
            cell2.createAndSyncToFirebase()
            cell3.createAndSyncToFirebase()
            cell4.createAndSyncToFirebase()
            cell5.createAndSyncToFirebase()
   
    }
}
