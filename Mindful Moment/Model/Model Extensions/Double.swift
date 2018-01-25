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
        
        let units = self.asTimeUnits
        
        var result = ""
        
        if units.hours > 0 {
            result += "\(units.hours) hr"
        }
        
        if units.minutes > 0 {
            if result != "" {
                result += ", "
            }
            result += "\(units.minutes) min"
        }
        
        if units.seconds > 0 {
            if result != "" {
                result += ", "
            }
            result += "\(units.seconds) sec"
        }
        
        return result
    }
    
    var timeCodeFormat: String {
        let units = self.asTimeUnits
        
        var result = ""
        
        if units.hours > 0 {
            result += "\(units.hours):"
        }
        
        if units.minutes < 10 {
            result += "0"
        }
        
        result += "\(units.minutes):"
        
        if units.seconds < 10 {
            result += "0"
        }
        
        result += "\(units.seconds)"
        
        return result
    }
    
    private var asTimeUnits: (hours: Int, minutes: Int, seconds: Int) {
        let totalSeconds = Int(floor(self))
        
        let totalMinutes = totalSeconds / 60
        let remainingSeconds = totalSeconds % 60
        
        let totalHours = totalMinutes / 60
        let remainingMinutes = totalMinutes % 60
        
        return (hours: totalHours, minutes: remainingMinutes, seconds: remainingSeconds)
    }
    
}
