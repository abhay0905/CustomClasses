//
//  ShadowView.swift
//  Abhay Shankar
//
//  Created by Abhay Shankar on 31/05/18.
//  Copyright © 2018 Abhay Shankar. All rights reserved.
//

import UIKit

/// Custom View with circular shadow
class ShadowView: UIView {

    var previousBound : CGRect = CGRect.zero
   
    override var bounds: CGRect {
        didSet {
            setupShadow()
        }
    }
    
    private func setupShadow() {
        
        if previousBound != self.bounds{
            previousBound = self.bounds
            self.clipsToBounds = false
            let shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: 3).cgPath
            shadowLayer.fillColor = UIColor.white.cgColor
            
            shadowLayer.shadowColor = UIColor.darkGray.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0.8, height: 1.2)
            shadowLayer.shadowOpacity = 0.3
            shadowLayer.shadowRadius = 0.7
            
            self.layer.insertSublayer(shadowLayer, at: 0)
        }
    }
}


