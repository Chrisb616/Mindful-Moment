//
//  UIView.swift
//  Mindful Moment
//
//  Created by Christopher Boynton on 12/21/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import UIKit

extension UIView {
    
    func standardFormat() {
        self.layer.cornerRadius = 5
        self.layer.borderColor = Colors.purple.cgColor
        self.layer.borderWidth = 5
        self.layer.shadowOpacity = 0.25
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: -5, height: 5)
    }
    
    func fadeAndDisable() {
        let greyView = UIView()
        greyView.alpha = 0
        self.addSubview(greyView)
        greyView.frame = self.frame
        greyView.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        greyView.accessibilityIdentifier = "Background Disabled"
        
        UIView.animate(withDuration: 0.5) {
            greyView.alpha = 1
        }
    }
    
    func removeFadeAndReenable() {
        for view in self.subviews {
            if view.accessibilityIdentifier == "Background Disabled" {
                
                UIView.animate(withDuration: 0.5, animations: {
                    view.alpha = 0
                }, completion: { (success) in
                    view.removeFromSuperview()
                })
                
            }
        }
    }
    
}
