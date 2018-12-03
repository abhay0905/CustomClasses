//
//  ReachabilityManager.swift
//  
//
//  Created by Abhay Shankar on 27/09/18.
//  Copyright © 2018 Self. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

/// for reachability. use *setupNetworkReachabilityObserver*
class ReachabilityManager {
    
    //shared instance
    static let shared = ReachabilityManager()
    var isConnected : Bool = true
    let internetReachability : Reachability = Reachability.forInternetConnection()
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func setupNetworkReachabilityObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(notitification:)), name:NSNotification.Name.reachabilityChanged, object: nil)
        
        internetReachability.startNotifier()
        updateReachability()
    }
    
    @objc private func reachabilityChanged(notitification:Notification){
        updateReachability()
    }
    
    private func updateReachability(){
        if internetReachability.currentReachabilityStatus() == NetworkStatus.init(0){
            //Not connected
            if isConnected{
                isConnected = false
                CustomAlert.shared.alertShow(show: true)
            }
        }else{
            //connected
            if !isConnected{
                isConnected = true
                CustomAlert.shared.alertShow(show: false)
            }
        }
    }
}
