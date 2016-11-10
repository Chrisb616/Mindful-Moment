//
//  HealthStore.swift
//  Flatiron Presents Health Kit App
//
//  Created by Christopher Boynton on 11/10/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import HealthKit

struct HealthStore {
    
    static let healthStore = HKHealthStore()
    private init(){}
    
    static func setUpHealthStore(){
        
        let typestoRead = Set([
            HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.mindfulSession)!
            ])
        
        let typestoShare = Set([
            HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.mindfulSession)!
            ])
        
        self.healthStore.requestAuthorization(toShare: typestoShare, read: typestoRead) { (success, error) -> Void in
            if success {
                print("Health Kit Authorized")
            } else {
                print("Health Kit Authorization Denied")
                if error != nil {
                    print("\(error.debugDescription)")
                }
            }
        }
        
    }
    
}
