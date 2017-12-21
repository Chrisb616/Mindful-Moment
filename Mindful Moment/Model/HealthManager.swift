//
//  HealthManager.swift
//  Mindful Moment
//
//  Created by Christopher Boynton on 12/18/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import Foundation
import HealthKit

struct HealthManager {
    
    private init() {}
    static let instance = HealthManager()
    
    let healthStore = HKHealthStore()
    
    func setUpHealthStore() {
        
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
    
    func saveSessionToMindfulMinutes(start: Date, end: Date) {
        let mindfulType = HKCategoryType.categoryType(forIdentifier: .mindfulSession)
        let mindfulSample = HKCategorySample(type: mindfulType!, value: 0, start: start, end: end)
        healthStore.save(mindfulSample) { success, error in
            if(error != nil) {
                print(error.debugDescription)
                abort()
            } else {
                print("Meditation saved!")
            }
        }
    }
    
    func retrieveMindfulMinutes(completion: @escaping ([HKSample]?, Error?) -> Void) {
        let distantPastSessions = Date.distantPast
        let currentDate = Date()
        let lastSessionsPredicate = HKQuery.predicateForSamples(withStart: distantPastSessions, end: currentDate, options: [])
        let mindfulType = HKCategoryType.categoryType(forIdentifier: .mindfulSession)
        
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        
        let meditationQuery = HKSampleQuery(sampleType: mindfulType!, predicate: lastSessionsPredicate, limit: 50, sortDescriptors: [sortDescriptor]) { (sampleQuery, results, error) in
            if let queryError = error {
                completion(nil, queryError)
            } else {
                completion(results, nil)
            }
        }
        
        self.healthStore.execute(meditationQuery)
    }
}
