//
//  Int.swift
//  MindfulMoment
//
//  Created by Christopher Boynton on 12/10/16.
//  Copyright © 2016 Christopher. All rights reserved.
//

import Foundation

extension Int {
    var convertedToTime: String {
        let seconds = self % 60
        let minutes = (self - seconds)/60
        
        return "\(minutes.forceTwoDigits):\(seconds.forceTwoDigits)"
    }
    var forceTwoDigits: String {
        if self < 10 {
            return "0\(self)"
        } else {
            return "\(self)"
        }
    }
}
