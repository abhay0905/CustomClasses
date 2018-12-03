//
//  AnimatedLoadingCircularButton.swift
//  
//
//  Created by Abhay Shankar on 14/08/18.
//  Copyright © 2018 Self. All rights reserved.
//

import UIKit

/// Custom button which animates to circle and starts a loader.
/// Call 'animateButton' and 'stopAnimation'.
class AnimatedLoadingCircularButton: UIButton {

    var isAnimating : Bool = false
    var title : String = ""
    var image : UIImage?
    var initialFrame : CGRect = CGRect.zero
    let duration : TimeInterval = 0.15
    var loaderType : UIActivityIndicatorView.Style = .white
    var initialCornerRadius : CGFloat = 0.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
     func animateButton() {
        
        if !isAnimating {
            UIApplication.shared.beginIgnoringInteractionEvents()
          isAnimating = true
            animateCornerRadius(status: true)
            animateWidth(status: true)
            self.addLoading(status: true)
        }
        
    }
    func stopAnimation()  {
        if isAnimating {
            UIApplication.shared.endIgnoringInteractionEvents()
            isAnimating = false
            addLoading(status: false)
            animateCornerRadius(status: false)
            animateWidth(status: false)
        }
    }
    
    fileprivate func animateCornerRadius(status:Bool) {
        if status{
            initialCornerRadius = self.layer.cornerRadius
        }
        
        let animation = CABasicAnimation(keyPath:"cornerRadius")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.fromValue = status ? initialCornerRadius
            : self.frame.size.height/2.0
        animation.toValue = status ? self.frame.size.height/2.0 : initialCornerRadius
        animation.duration = duration
        animation.fillMode = CAMediaTimingFillMode.forwards
        self.layer.add(animation, forKey: "cornerRadius")
        animation.isRemovedOnCompletion = false
        self.layer.cornerRadius = status ? self.frame.size.height/2.0 : initialCornerRadius
    }
    
    fileprivate func animateWidth(status:Bool) {
        if status{
            if let str = self.titleLabel?.text{
                title = str
            }
            if let str = self.imageView?.image{
                image = str
            }
            initialFrame = self.frame
            self.setTitle("", for: .normal)
            self.setImage(nil, for: .normal)
            var toFrame = initialFrame
            toFrame.size.width = initialFrame.size.height
          
            let animation = CABasicAnimation(keyPath:"bounds")
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
            animation.fromValue = initialFrame
            animation.toValue =  toFrame
            animation.duration = duration
            animation.isRemovedOnCompletion = false
            animation.fillMode = CAMediaTimingFillMode.forwards
            self.layer.add(animation, forKey: "bounds")
            self.layer.bounds = toFrame
            
        }
        else{
            
            let animation = CABasicAnimation(keyPath:"bounds")
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
            animation.fillMode = CAMediaTimingFillMode.forwards
            animation.fromValue = self.frame
            animation.toValue =  initialFrame
            animation.duration = duration
            self.layer.add(animation, forKey: "bounds")
            self.layer.bounds = initialFrame
            animation.isRemovedOnCompletion = false
            self.setTitle(self.title, for: .normal)
            self.setImage(image, for: .normal)
        }
    }
    
    fileprivate func addLoading(status:Bool){
        if status{
            let loader = UIActivityIndicatorView.init(style: loaderType)
            loader.tag = 987
            loader.alpha = 0
            loader.frame = self.layer.bounds
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

