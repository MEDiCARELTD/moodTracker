//
//  AppDelegate.swift
//  MoodTracker
//
//  Created by App Camp on 22/07/2016.
//  Copyright © 2016 Daniel. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import GooglePlaces


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var accountLogData: [MoodLog]=[]
    var userAlarms : [Alarm] = []
        // Contact numbers
    let lifeline = "tel://08088088000";
    
    let samaritainsUK = "tel://116123"
    
    let samaritainsROI = "tel://116123"
    
    

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        GMSPlacesClient.provideAPIKey("AIzaSyDM_DRJ80C-cwx-x_6URnJCBVTmEkM7qlU")

        //Setting up Firebase
        FIRApp.configure()
        FIRDatabase.database().persistenceEnabled = false
        
//        UIApplication.sharedApplication().cancelAllLocalNotifications()
        // types are UIUserNotificationType values
//        application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil))
        
        
        //SHANNONS ATTEMPT!
        
        let notificationSettings = UIUserNotificationSettings(forTypes: [.Badge, .Sound, .Alert], categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)
        
        
        
        
        

        return true
    }
    
    func application(application: UIApplication,
                     openURL url: NSURL, options: [String: AnyObject]) -> Bool {
        return GIDSignIn.sharedInstance().handleURL(url,
                                                    sourceApplication: options[UIApplicationOpenURLOptionsSourceApplicationKey] as? String,
                                                    annotation: options[UIApplicationOpenURLOptionsAnnotationKey])
    }
    func application(application: UIApplication,
                     openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        var options: [String: AnyObject] = [UIApplicationOpenURLOptionsSourceApplicationKey: sourceApplication!,
                                            UIApplicationOpenURLOptionsAnnotationKey: annotation]
        return GIDSignIn.sharedInstance().handleURL(url,
                                                    sourceApplication: sourceApplication,
                                                    annotation: annotation)
    }
    

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    

}

