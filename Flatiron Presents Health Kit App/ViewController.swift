//
//  ViewController.swift
//  Flatiron Presents Health Kit App
//
//  Created by Christopher Boynton on 10/24/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import HealthKit
class ViewController: UIViewController {
    
    var backgroundColor01 = UIColor.init(red: 143/255, green: 201/255, blue: 185/255, alpha: 1)
    var backgroundColor02 = UIColor.init(red: 216/255, green: 217/255, blue: 192/255, alpha: 1)
    var backgroundColor03 = UIColor.init(red: 209/255, green: 142/255, blue: 143/255, alpha: 1)
    var backgroundColor04 = UIColor.init(red: 171/255, green: 92/255, blue: 114/255, alpha: 1)
    var backgroundColor05 = UIColor.init(red: 145/255, green: 51/255, blue: 79/255, alpha: 1)
    var backgroundColor06 = UIColor()
    var backgroundColor07 = UIColor()
    var backgroundColor08 = UIColor()
    var backgroundColor09 = UIColor()
    var backgroundColor10 = UIColor()
    
    
    let healthStore = HKHealthStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let date = Date(timeIntervalSinceNow: 0)
        let mintes: UInt = 10
        print(date)
        print(mintes)
        
        
        
        saveMeditation(startDate: date, minutes: mintes)
        
        let typestoRead = Set([
            HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.mindfulSession)!
            ])
        
        let typestoShare = Set([
            HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.mindfulSession)!
            ])
        
        self.healthStore.requestAuthorization(toShare: typestoShare, read: typestoRead) { (success, error) -> Void in
            if success == false {
                print(" Display not allowed")
            }
        }
    }
    
    
    
    
    func saveMeditation(startDate:Date, minutes:UInt) {
        let mindfulType = HKCategoryType.categoryType(forIdentifier: .mindfulSession)
        let mindfulSample = HKCategorySample(type: mindfulType!, value: 0, start: Date.init(timeIntervalSinceNow: -(10*60)), end: Date())
        healthStore.save(mindfulSample) { success, error in
            if(error != nil) {
                abort()
            }else{
                print("Meditation saved!")
            }
        }
    }
    
    
    
    
    
    
    
    

}

    
    
    
