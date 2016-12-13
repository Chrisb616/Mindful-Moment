//
//  StarView.swift
//  MindfulMoment
//
//  Created by Christopher Boynton on 12/13/16.
//  Copyright © 2016 Christopher. All rights reserved.
//

import UIKit

class StarView: UIView {
    
    var starImageView: UIImageView = UIImageView(image: UIImage(named: "Star"))
    
    var twinkleDuration: TimeInterval = 10
    var twinkleScale: Double = 1.5
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addFittedSubview(starImageView)
    }
    
    func twinkle() {
        let spinAnimation = CAKeyframeAnimation(keyPath: "transform.rotation")
        
        spinAnimation.values = [0, M_PI * 3, M_PI * 3]
        spinAnimation.keyTimes = [0,0.1,1]
        spinAnimation.duration = twinkleDuration
        spinAnimation.repeatCount = Float.infinity
        
        starImageView.layer.add(spinAnimation, forKey: "transform.rotation")
        
        let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        
        scaleAnimation.values = [1,twinkleScale,1,1]
        scaleAnimation.keyTimes = [0,0.05,0.1,1]
        scaleAnimation.duration = twinkleDuration
        scaleAnimation.repeatCount = Float.infinity
        
        starImageView.layer.add(scaleAnimation, forKey: "transform.scale")
    }
    
    
}
