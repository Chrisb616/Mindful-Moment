//
//  MoonView.swift
//  MindfulMoment
//
//  Created by Christopher Boynton on 12/12/16.
//  Copyright © 2016 Christopher. All rights reserved.
//

import UIKit

class MoonView: UIView {
    
    
    enum MoonPhase: Int, CustomStringConvertible {
        case new = 0
        case waxingCrescent
        case firstQuarter
        case waxingGibbous
        case full
        case waningGibbous
        case thirdQuarter
        case waningCrescent
        
        
        var image: UIImage? {
            return UIImage(named: self.description)
        }
        
        var description: String {
            switch self {
            case .new: return ""
            case .waxingCrescent: return "WaxingCrescent"
            case .firstQuarter: return "FirstQuarter"
            case .waxingGibbous: return "WaxingGibbous"
            case .full: return "FullMoonSun"
            case .waningGibbous: return "WaningGibbous"
            case .thirdQuarter: return "ThirdQuarter"
            case .waningCrescent: return "WaningCrescent"
            }
        }
    }
    
    var moonValue = MoonPhase.new
    var moonImageView: UIImageView?
    
    override func layoutSubviews() {
        
        self.transform = CGAffineTransform(rotationDegrees: 30)
        self.addFittedSubview(moonImageView!)
    }
    
    func advanceMoon() {
        switch moonValue {
        case .new: moonValue = MoonPhase.waxingCrescent
        case .waxingCrescent: moonValue = MoonPhase.firstQuarter
        case .firstQuarter: moonValue = MoonPhase.waxingGibbous
        case .waxingGibbous: moonValue = MoonPhase.full
        case .full: moonValue = MoonPhase.waningGibbous
        case .waningGibbous: moonValue = MoonPhase.thirdQuarter
        case .thirdQuarter: moonValue = MoonPhase.waningCrescent
        case .waningCrescent: moonValue = MoonPhase.new
        }
        print(moonValue)
        
        moonImageView = nil
        moonImageView = UIImageView(image: moonValue.image)
    }
}
