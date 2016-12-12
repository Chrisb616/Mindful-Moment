//
//  MoonView.swift
//  MindfulMoment
//
//  Created by Christopher Boynton on 12/12/16.
//  Copyright © 2016 Christopher. All rights reserved.
//

import UIKit

class MoonView: UIView {
    
    enum MoonImage: String {
        case new = ""
        case waxingCrescent = "WaxingCrescent"
        case firstQuarter = "FirstQuarter"
        case waxingGibbous = "WaxingGibbous"
        case full = "Full"
        case waningGibbous = "WaningGibbous"
        case thirdQuarter = "ThirdQuarter"
        case waningCrescent = "WaningCrescent"
        
        
        var image: UIImage {
            return UIImage(named: self.rawValue)!
        }
        
        
    }
    
    var moonValue = MoonImage.waxingCrescent
    var moonImageView: UIImageView!
    
    override func layoutSubviews() {
        moonImageView = UIImageView(image: moonValue.image)
        
        self.addFittedSubview(moonImageView)
    }
    
    func advanceMoon() {
        
        
        moonImageView.image = MoonImage.waningCrescent.image
    }
}
