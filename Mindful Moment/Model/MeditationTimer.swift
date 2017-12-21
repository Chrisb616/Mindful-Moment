//
//  MeditationTimer.swift
//  Mindful Moment
//
//  Created by Christopher Boynton on 12/18/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import Foundation

class MeditationTimer {
    
    static var current: MeditationTimer?
    
    let start: Date
    
    var end: Date?
    
    init() {
        self.start = Date()
    }
    
    func finish() {
        self.end = Date()
    }
    
    var session: Session? {
        if let end = end {
            return Session(startDate: start, endDate: end)
        } else {
            print("Cannot create session because the timer has no end point")
            return nil
        }
    }
    
}
