//
//  DataStore.swift
//  Flatiron Presents Health Kit App
//
//  Created by Christopher Boynton on 11/15/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import HealthKit

class DataStore {
    static let sharedInstance = DataStore()
    private init() {}
    
    let healthStore = HealthManager.healthStore
    
    var sessions = [Session]()
    
    
    func getMeditationsFromHeath(_ completion: @escaping ()-> Void) {
        HealthManager.getMeditations { (sample, error) in
            var tempSessions = [Session]()
            
            if let error = error {
                print(error.localizedDescription)
            } else {
                for item in sample! {
                    tempSessions.append(Session(startDate: item.startDate, endDate: item.endDate))
                }
                
                self.sessions.removeAll()
                self.sessions = tempSessions
                OperationQueue.main.addOperation {
                    completion()
                }
            }
            
        }
    }
}
