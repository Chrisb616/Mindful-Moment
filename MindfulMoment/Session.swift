//
//  Session.swift
//  Flatiron Presents Health Kit App
//
//  Created by Christopher Boynton on 11/14/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation

struct Session {
    var startDate = Date()
    var duration = TimeInterval()
}

extension Session {

    var durationDouble: Double { return Double(duration) }
    
    var startDateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        return dateFormatter.string(from: startDate)
    }
    
    var startTimeString: String { let dateFormatter = DateFormatter(); dateFormatter.dateFormat = "hh:mmaa"; return dateFormatter.string(from: startDate) }
    
    var startTimeAndDateString: String { return "\(startDateString) \(startTimeString)" }
    
    var durationString: String { return Int(duration).convertedToTime }
    
    init(startDate: Date, endDate: Date){
        self.startDate = startDate
        self.duration = endDate.timeIntervalSince(startDate)
    }
}
