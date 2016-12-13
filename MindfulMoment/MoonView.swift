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
    
    var moonValue = MoonImage.new
    var moonImageView: UIImageView?
    
    override func layoutSubviews() {
        moonImageView = UIImageView(image: moonValue.image)
        
        self.addFittedSubview(moonImageView!)
    }
    
    func advanceMoon() {
        switch moonValue {
        case .new: moonValue = MoonImage.waxingCrescent
        case .waxingCrescent: moonValue = MoonImage.firstQuarter
        case .firstQuarter: moonValue = MoonImage.waxingGibbous
        case .waxingGibbous: moonValue = MoonImage.full
        case .full: moonValue = MoonImage.waningGibbous
        case .waningGibbous: moonValue = MoonImage.thirdQuarter
        case .thirdQuarter: moonValue = MoonImage.waningCrescent
        case .waningCrescent: moonValue = MoonImage.new
        }
        print(moonValue)
        
        moonImageView = nil
        moonImageView = UIImageView(image: moonValue.image)
    }
}
