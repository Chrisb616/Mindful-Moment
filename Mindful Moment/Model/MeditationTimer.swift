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
    
    func finish() -> Session? {
        if let start = start {
            let session = Session(startDate: start, endDate: Date())
            
            self.start = nil
            
            return session
        }
        return nil
    }
    
}
