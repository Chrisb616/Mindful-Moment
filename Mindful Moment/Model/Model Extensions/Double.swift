//
//  Double.swift
//  Mindful Moment
//
//  Created by Christopher Boynton on 12/22/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import Foundation

extension TimeInterval {
    
    var timeUnitFormat: String {
        
        let totalSeconds = Int(floor(self))
        
        let totalMinutes = totalSeconds / 60
        let remainingSeconds = totalSeconds % 60
        
        let totalHours = totalMinutes / 60
        let remainingMinutes = totalMinutes % 60
        
        var result = ""
        
        if totalHours > 0 {
            result += "\(totalHours) hr"
        }
        
        if remainingMinutes > 0 {
            if result != "" {
                result += ", "
            }
            result += "\(remainingMinutes) min"
        }
        
        if remainingSeconds > 0 {
            if result != "" {
                result += ", "
            }
            result += "\(remainingSeconds) sec"
        }
        
        return result
    }
    
}
