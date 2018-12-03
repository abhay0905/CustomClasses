//
//  LoadingButtonWithActivityIndicator.swift
//  
//
//  Created by Abhay Shankar on 03/12/18.
//  Copyright © 2018 Self. All rights reserved.
//

import Foundation
import UIKit

/// Loading button with activity indicator inside.
/// Call 'animateButton' and 'stopAnimation'.
class LoadingButtonWithActivityIndicator: UIButton {
    
    var isAnimating : Bool = false
    var title : String = ""
    var image : UIImage?
    var initialFrame : CGRect = CGRect.zero
    let duration : TimeInterval = 0.15
    var loaderType : UIActivityIndicatorView.Style = .white
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func animateButton() {
        
        if !isAnimating {
            UIApplication.shared.beginIgnoringInteractionEvents()
            isAnimating = true
            if let str = self.titleLabel?.text{
                title = str
            }
            if let str = self.imageView?.image{
                image = str
            }
            self.setTitle("", for: .normal)
            self.setImage(nil, for: .normal)
            self.addLoading(status: true)
        }
        
    }
    func stopAnimation()  {
        if isAnimating {
            UIApplication.shared.endIgnoringInteractionEvents()
            isAnimating = false
            
            addLoading(status: false)
            self.setTitle(self.title, for: .normal)
            self.setImage(image, for: .normal)
        }
    }
    
    fileprivate func addLoading(status:Bool){
        if status{
            let loader = UIActivityIndicatorView.init(style: loaderType)
            loader.tag = 987
            loader.alpha = 0
            loader.frame = self.bounds
            self.addSubview(loader)
            self.bringSubviewToFront(loader)
            
            loader.startAnimating()
            UIView.animate(withDuration: 0.1) {
                loader.alpha = 1.0
            }
        }
        else{
            if let loader = self.viewWithTag(987){
                loader.removeFromSuperview()
            }
        }
    }
}
