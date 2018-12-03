//
//  CustomAlert.swift
//  
//
//  Created by Abhay Shankar on 27/08/18.
//  Copyright © 2018 Self. All rights reserved.
//

import Foundation
import UIKit

/// SnackBar implementation for iOS
class CustomAlert: NSObject {
    
    //MARK: - Singleton
    static let shared = CustomAlert()

    //MARK: - Variables
    private var isVisible : Bool = false
    private var alertHeight : CGFloat = 20.0
    private let alertBGColor : UIColor = UIColor.init(red: 1.0, green: 0, blue: 0, alpha: 0.6)
    private let sucessBGColor : UIColor = UIColor.init(red: 50, green: 205, blue: 50, alpha: 0.6)

    private var label : UILabel?
    private var view : UIView?
    private var viewNoInternet : UIView?
    private var isVisibleNoInternet : Bool = false
    
    private let appDelegator = UIApplication.shared.delegate! as! AppDelegate
    
    //MARK: - Methods
    
    
    /// Display Alert with error msg.
    ///
    /// - Parameter errorMsg: Error message
    func showErrorAlertWithString(errorMsg:String) {
        if !isVisible{
            isVisible = true
            if view == nil{
                initViewWithFrame(frame: getFrame())
            }
            else{
                view?.frame = getFrame()
            }
            view?.backgroundColor = alertBGColor
            label?.text = errorMsg
            view?.alpha = 0.0
            appDelegator.window?.addSubview(view!)
            showAlertForTime(time: 1.5)
        }
    }
    /// Persistent Alert for No Internet
    ///
    /// - Parameter show: True to show. False to hide.
    func showNoInternetAlert(show:Bool) {
        if show{
            if !isVisibleNoInternet{
                 isVisibleNoInternet = true
                if viewNoInternet == nil{
                    viewNoInternet = UIView.init(frame: getFrame())
                    let label = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: viewNoInternet!.frame.size.height))
                    label.textColor = UIColor.white
                    label.font = UIFont.init(fontType: AvenirNextFont.Medium, with: 12)
                    label.textAlignment = .center
                    label.text = "No Internet"
                    viewNoInternet?.addSubview(label)
                }
                else{
                    viewNoInternet?.frame = getFrame()
                }
               
                viewNoInternet?.backgroundColor = alertBGColor
                viewNoInternet?.alpha = 1.0
                appDelegator.window?.addSubview(viewNoInternet!)
            }
           
        }else{
            UIView.animate(withDuration: 0.15, delay: 0.2, options: .curveLinear, animations: {
                self.viewNoInternet?.alpha = 0.0
            }, completion: { (complete) in
                self.isVisibleNoInternet = false
                self.viewNoInternet?.removeFromSuperview()
            })
        }
    }
    
    /// Shows alert for sucess msg
    ///
    /// - Parameter sucessMsg: Sucess Msg
    func showSuccessAlertWithString(sucessMsg:String) {
        if !isVisible{
            isVisible = true
            if view == nil{
                initViewWithFrame(frame: getFrame())
            }
            else{
                view?.frame = getFrame()
            }
            view?.backgroundColor = sucessBGColor
            label?.text = sucessMsg
            view?.alpha = 0.0
            appDelegator.window?.addSubview(view!)
            showAlertForTime(time: 1.5)
        }
    }
    //MARK: - Private Methods
    
    private func showAlertForTime(time:TimeInterval){
        if #available(iOS 10.0, *) {
            FeedbackGenerator.notify(status: UINotificationFeedbackGenerator.FeedbackType.error)
        }
        UIView.animate(withDuration: 0.15, animations: {
            self.view?.alpha = 1.0
        }) { (complete) in
            if complete{
                UIView.animate(withDuration: 0.15, delay: time, options: .curveLinear, animations: {
                    self.view?.alpha = 0.0
                }, completion: { (complete) in
                    self.isVisible = false
                    self.view?.removeFromSuperview()
                })
            }
        }
    }

    private func initViewWithFrame(frame:CGRect){
         view = UIView.init(frame: frame)
        if label == nil{
            label = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: frame.size.height))
            label?.textColor = UIColor.white
            label?.font = UIFont.init(fontType: AvenirNextFont.Medium, with: 12)
            label?.textAlignment = .center
            view?.addSubview(label!)
        }
    }
    fileprivate func getFrame() -> CGRect {
        let frame = CGRect.init(x: 0, y: UIScreen.main.bounds.height - getSafeAreaBottom() - alertHeight, width: UIScreen.main.bounds.width, height: alertHeight)
        return frame
    }
    
   
    
    private func getSafeAreaBottom() -> CGFloat{
         if #available(iOS 11.0, *) {
            let bottomPadding = appDelegator.window!.safeAreaInsets.bottom;
            return bottomPadding
        }
         return 0.0
    }
}
