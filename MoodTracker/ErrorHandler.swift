//
//  ErrorPromptLogs.swift
//  MoodTracker
//
//  Created by App Camp on 08/08/2016.
//  Copyright © 2016 Daniel. All rights reserved.
//

import Foundation
import SCLAlertView
import Firebase
class ErrorHandler {
    
    
    var alert = SCLAlertView()
    // Initialize SCLAlertView using custom Appearance
    let appearance = SCLAlertView.SCLAppearance(
        showCloseButton: false
    )
    
    func searchError(error: NSError) -> FIRAuthErrorCode{
        
        alert = SCLAlertView(appearance: appearance)
        let errorCode = FIRAuthErrorCode(rawValue: error.code)
        print(errorCode)
        
        switch errorCode! {
            
        case FIRAuthErrorCode.ErrorCodeInvalidEmail:
            self.alert.showError("Email is Invalid", subTitle: "Check the sepelling of email", duration: 2)
            print(error)
            
        case .ErrorCodeUserDisabled:
            self.alert.showError("Your account has been suspended", subTitle: "", duration: 2)
            print(error)
            
        case .ErrorCodeUserMismatch:
            self.alert.showError("problems with the server side", subTitle: "Try to connect later", duration: 2)

            print(error)
        case .ErrorCodeEmailAlreadyInUse:
            self.alert.showError("Email is already in use", subTitle: "", duration: 2)
            print(error)
        case . ErrorCodeWrongPassword:
            self.alert.showError("Password is incorrect", subTitle: "", duration: 2)
            print(error)
        case .ErrorCodeTooManyRequests:
            self.alert.showError("The connection is busy", subTitle: "Try again later", duration: 2)

            print(error)
        case .ErrorCodeUserNotFound:
            self.alert.showError("cannot find account", subTitle: "Check that your credentials are correct", duration: 2)

        case .ErrorCodeNetworkError:
            self.alert.showError("Bad internet connection", subTitle: "Try again later", duration: 2)
            print(error)
            
        case .ErrorCodeUserTokenExpired:
            self.alert.showError("Sign in again", subTitle: "you haven't signed in recently", duration: 2)
            print(error)
        
         
        case.ErrorCodeWeakPassword:
            self.alert.showError("weak Password", subTitle: "6 characters long or more", duration: 2)
            print(error)
        
        case .ErrorCodeAccountExistsWithDifferentCredential:
            print(error)
        case .ErrorCodeRequiresRecentLogin:
            print(error)
        case .ErrorCodeProviderAlreadyLinked:
            print(error)
        case .ErrorCodeInvalidUserToken:
            print(error)
        case .ErrorCodeCredentialAlreadyInUse:
            print(error)
        case .ErrorCodeInternalError:
            print(error)
        
        default:
            print(error)
        }
        return errorCode!
    }
}