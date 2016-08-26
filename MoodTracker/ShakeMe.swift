//
//  ShakeUI.swift
//  MoodTracker
//
//  Created by App Camp on 12/08/2016.
//  Copyright © 2016 Daniel. All rights reserved.
//

import Foundation
import UIKit

class ShakeMe {
    
    //Shake me component
    let animation = CABasicAnimation(keyPath: "position")
    
    func shake(tableCell: UITableViewCell){
        animation.duration = 0.07
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(CGPoint: CGPointMake(tableCell.center.x - 10, tableCell.center.y))
        animation.toValue = NSValue(CGPoint: CGPointMake(tableCell.center.x + 10, tableCell.center.y))
        tableCell.layer.addAnimation(animation, forKey: "position")
    }
    
    func shakeMeIfEmpty(textField: UITextField)-> Bool{
        if textField.text == ""
        {
            animation.duration = 0.07
            animation.repeatCount = 3
            animation.autoreverses = true
            animation.fromValue = NSValue(CGPoint: CGPointMake(textField.center.x - 10, textField.center.y))
            animation.toValue = NSValue(CGPoint: CGPointMake(textField.center.x + 10, textField.center.y))
            textField.layer.addAnimation(animation, forKey: "position")
            return true
        }
        else{
            return false
        }
    }
    
}