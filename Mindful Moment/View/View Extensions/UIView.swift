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
    
    //MARK: - Animations

    func animatePosition(changeX: CGFloat, changeY: CGFloat, withDuration duration: TimeInterval, easeIn: Bool, easeOut: Bool) {
        let originalPosition = CGPoint(x: self.center.x, y: self.center.y)
        let finalPosition = CGPoint(x: self.center.x + changeX, y: self.center.y + changeY)
        
        let animation = basicAnimationWith(keyPath: AnimationKeypaths.position, fromValue: [originalPosition.x, originalPosition.y], toValue: [finalPosition.x, finalPosition.y], duration: duration, easeIn: easeIn, easeOut: easeOut)
        self.layer.add(animation, forKey: animation.keyPath)
        self.center = CGPoint(x: finalPosition.x, y: finalPosition.y)
    }

    // This was an attempt to deconstruct these functions because I thought I needed both. Likely only need the first one though. Leaving in just in case
    /*
    func animatePosition(changeX: CGFloat, changeY: CGFloat, withDuration duration: TimeInterval, easeIn: Bool, easeOut: Bool) {
        let originalPosition = CGPoint(x: self.center.x, y: self.center.y)
        let finalPosition = CGPoint(x: self.center.x + changeX, y: self.center.y + changeY)
 
        animatePosition(originalPosition: originalPosition, finalPosition: finalPosition, withDuration: duration, easeIn: easeIn, easeOut: easeOut)
 
    }
 
    func animatePosition(toPoint finalPoint: CGPoint, withDuration duration: TimeInterval, easeIn: Bool = false, easeOut: Bool = false) {
        let originalPosition = CGPoint(x: self.center.x, y: self.center.y)
        
        animatePosition(originalPosition: originalPosition, finalPosition: finalPoint, withDuration: duration, easeIn: easeIn, easeOut: easeOut)
        
    }
    
    private func animatePosition(originalPosition: CGPoint, finalPosition: CGPoint, withDuration duration: TimeInterval, easeIn: Bool, easeOut: Bool) {
        
    }
     */
    
    private func basicAnimationWith(keyPath: String, fromValue: Any?, toValue: Any?, duration: TimeInterval, easeIn: Bool, easeOut: Bool) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: keyPath)
        animation.fromValue = fromValue
        animation.toValue = toValue
        animation.duration = duration
        
        if easeIn && easeOut {
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        } else if easeIn {
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        } else if easeOut {
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        }
        
        return animation
    }
    
}
