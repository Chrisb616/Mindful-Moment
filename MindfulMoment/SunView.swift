//
//  SunView.swift
//  MindfulMoment
//
//  Created by Christopher Boynton on 12/12/16.
//  Copyright © 2016 Christopher. All rights reserved.
//

import UIKit

class SunView: UIView {
    
    var sunCenterImageView: UIImageView = UIImageView(image: UIImage.fullMoonSun)
    var sunRaysImageView: UIImageView = UIImageView(image: UIImage.sunRays)
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutImageViews()
        animateRays()
    }
    
    func layoutImageViews(){
        print("Laying out")
        
        self.addFittedSubview(sunCenterImageView)
        self.addFittedSubview(sunRaysImageView)
    }
    
    func animateRays() {
        
        let raysRotation = CABasicAnimation(keyPath: "transform.rotation")
        raysRotation.fromValue = 0.0
        raysRotation.toValue = CGFloat(M_PI * 2)
        raysRotation.duration = 10
        raysRotation.repeatCount = Float.infinity
        self.sunRaysImageView.layer.add(raysRotation, forKey: "transform.rotation")
        
        let raysBounce = CAKeyframeAnimation(keyPath: "transform.scale")
        raysBounce.values = [1.05,0.95,1.05]
        raysBounce.keyTimes = [0,0.5,1]
        raysBounce.duration = 5
        raysBounce.repeatCount = Float.infinity
        self.sunRaysImageView.layer.add(raysBounce, forKey: "transform.scale")
    }
    func stopAnimations() {
        self.layer.removeAllAnimations()
    }
    
    
}
