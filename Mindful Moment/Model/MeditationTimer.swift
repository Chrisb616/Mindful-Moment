//
//  MeditationTimer.swift
//  Mindful Moment
//
//  Created by Christopher Boynton on 12/18/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import Foundation

class MeditationTimer {
    
    //MARK: - Instance
    static let instance: MeditationTimer = MeditationTimer()
    
    //MARK: - Stored Properties
    private var start: Date?
    private var end: Date?
    
    private init() {
        
    }
    
    func begin() {
        start = Date()
    }
    
    var currentDuration: TimeInterval? {
        if let start = start {
            return Date().timeIntervalSince(start)
        }
        return nil
    }
    
    func finish() {
        end = Date()
    }
    
    var session: Session? {
        
        if let start = start, let end = end {
            let session = Session(startDate: start, endDate: end)
            
            return session
        }
        return nil
    }
    
}
