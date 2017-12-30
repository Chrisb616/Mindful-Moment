//
//  ActionTimer.swift
//  Mindful Moment
//
//  Created by Christopher Boynton on 12/30/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import Foundation

class ActionTimer {
    
    private var target: TimeInterval
    private var startDate: Date?
    private var action: () -> Void
    
    init(target: TimeInterval, action: @escaping () -> Void) {
        self.target = target
        self.action = action
    }
    
    func reset() {
        startDate = Date()
    }
    
    func run() {
        reset()
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(countUp), userInfo: nil, repeats: true)
    }
    
    @objc func countUp() {
        if let startDate = startDate {
            
            if Date().timeIntervalSince(startDate) >= target {
                action()
                self.startDate = nil
            }
        }
    }
    
}
