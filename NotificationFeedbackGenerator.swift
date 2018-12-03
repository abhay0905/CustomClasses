//
//  NotificationFeedbackGenerator.swift
//  
//
//  Created by Abhay Shankar on 22/10/18.
//  Copyright © 2018 Self. All rights reserved.
//

import Foundation
import UIKit

struct FeedbackGenerator {
    
    @available(iOS 10.0, *)
    static let notification = UINotificationFeedbackGenerator()
   
    /// Create Haptic feedback
    ///
    /// - Parameters:
    ///     - status : Type of *feedback*
    /**
     
     *FeedbackType* types
     *SuccessType
     *WarningType
     *ErrorType
     */
    @available(iOS 10.0, *)
    static func notify(status:UINotificationFeedbackGenerator.FeedbackType){
        notification.notificationOccurred(status)
    }
    
    /// Create Haptic Impact- Light
    static func generateImpactLight(){
        if #available(iOS 10.0, *) {
            let mediumImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)
            mediumImpactFeedbackGenerator.prepare()
            mediumImpactFeedbackGenerator.impactOccurred()
        }
    }
    
    /// Create Haptic Impact- Medium
    static func generateMeduim(){
        if #available(iOS 10.0, *) {
            let mediumImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
            mediumImpactFeedbackGenerator.prepare()
            mediumImpactFeedbackGenerator.impactOccurred()
        }
    }
}
