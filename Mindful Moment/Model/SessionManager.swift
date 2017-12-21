//
//  SessionManager.swift
//  Mindful Moment
//
//  Created by Christopher Boynton on 12/18/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import Foundation

class SessionManager {
    
    private init() {}
    static let instance = SessionManager()
    
    var storedSessions = [Session]()
    
    func loadSessionsFromHealthStore(_ completion: @escaping ()-> Void) {
        
        HealthManager.instance.retrieveMindfulMinutes { (sample, error) in
        
            if let error = error {
                print(error.localizedDescription)
            }
            
            if let sample = sample {
                self.storedSessions.removeAll()
                self.storedSessions = sample.map{ Session(startDate: $0.startDate, endDate: $0.endDate) }
                
                OperationQueue.main.addOperation {
                    completion()
                }
            }
        }
    }
}
