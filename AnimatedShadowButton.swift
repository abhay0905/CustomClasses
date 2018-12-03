//
//  AnimatedShadowButton.swift
//  
//
//  Created by Abhay Shankar on 03/12/18.
//  Copyright © 2018 Self. All rights reserved.
//

import Foundation
import UIKit

/// Custom button with circular shadow that animates on/off with tap
class AnimatedShadowButton: UIButton {
    
    var previousBound : CGRect = CGRect.zero
    var shadowLayer : CAShapeLayer!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addTouchBeginAction()
        addTouchEndAction()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addTouchBeginAction()
        addTouchEndAction()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupShadow()
    }
    override var bounds: CGRect {
        didSet {
            setupShadow()
        }
    }
    // MARK: - Animations
    
    private func setupShadow() {
        
        if previousBound != self.bounds{
            previousBound = self.bounds
            self.clipsToBounds = false
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.bounds.size.height / 2.0).cgPath
            shadowLayer.fillColor = self.backgroundColor?.cgColor ?? UIColor.white.cgColor
            
            shadowLayer.shadowColor = UIColor.darkGray.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0.8, height: 0.8)
            shadowLayer.shadowOpacity = 0.7
            shadowLayer.shadowRadius = 2.0
            
            self.layer.insertSublayer(shadowLayer, at: 0)
            self.layer.cornerRadius = self.bounds.size.height / 2.0
        }
        
    }
    
    
    private func addTouchBeginAction() {
        
        self.addTarget(self, action: #selector(animateTouchBegin), for: .touchDown)
        
    }
    private func addTouchEndAction() {
        
        self.addTarget(self, action: #selector(animateTouchEnd), for: .touchUpInside)
        self.addTarget(self, action: #selector(animateTouchEnd), for: .touchCancel)
        self.addTarget(self, action: #selector(animateTouchEnd), for: .touchDragExit)
    }
    
    @objc private func animateTouchBegin(){
        let animation = CABasicAnimation(keyPath: "shadowOpacity")
        animation.fromValue = layer.shadowOpacity
        animation.toValue = 0.0
        animation.duration = 0.1
        shadowLayer.add(animation, forKey: "shadowOpacity")
        shadowLayer.shadowOpacity = 0.0
        
        UIView.animate(withDuration: 0.1) {
            self.transform = CGAffineTransform(scaleX: 0.99, y: 0.99)
        }
    }
    
    @objc private func animateTouchEnd(){
        let animation = CABasicAnimation(keyPath: "shadowOpacity")
        animation.fromValue = layer.shadowOpacity
        animation.toValue = 0.7
        animation.duration = 0.1
        shadowLayer.add(animation, forKey: "shadowOpacity")
        shadowLayer.shadowOpacity = 0.7
        
        UIView.animate(withDuration: 0.1) {
            self.transform = CGAffineTransform.identity
        }
    }
}
