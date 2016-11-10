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
    
    let healthStore = HealthStore.healthStore
    
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    let startButtonTapGesture = UIGestureRecognizer()
    
    var countIsActive = false
    
    var timer = Timer()
    var secondsInTime = 0
    
    var startTime = Date()
    var endTime = Date()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        
        let queue = OperationQueue()
        
        queue.addOperation {
            HealthStore.setUpHealthStore()
        }
        
        
        print("View Did load")
        
        
        
        self.view.layoutIfNeeded()
        
        
        //let date = Date()
        //saveMeditation(seconds: date.timeIntervalSinceNow)
    }
    
    
    func setUpViews() {
        print(startButton.allTargets)
        startButton.layer.cornerRadius = 10
        startButton.layer.borderColor = UIColor.purpleMountain.cgColor
        startButton.layer.borderWidth = 3
        startButton.layer.shadowColor = UIColor.black.cgColor
        startButton.layer.shadowOpacity = 1
        startButton.layer.shadowOffset = CGSize(width: 2, height: 5)
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        print(startButton.allTargets)
        startButton.addSubview(startLabel)
        //startButton.layer.shadowRadius = 5
    }
    
    func startButtonTapped(_ sender: UIButton) {
        if countIsActive {
            countIsActive = false
            
            print("Stop Button Tapped")
            sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            startLabel.text = "Start"
            
            UIView.animate(withDuration: 0.5, animations: {
                sender.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.view.layoutIfNeeded()
            })
            
            
            endTimer()
            saveMeditation(start: startTime, end: endTime)
            
        } else {
            print("Start Button Tapped")
            sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            startLabel.text = "Stop"
            
            UIView.animate(withDuration: 0.5, animations: {
                sender.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.view.layoutIfNeeded()
            })
            
            countIsActive = true
            startTimer()
        }
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        startTime = Date()
    }
    func endTimer() {
        timer.invalidate()
        endTime = Date()
        secondsInTime = 0
    }
    func updateTime(_ sender: Timer) {
        secondsInTime += 1
        print(secondsInTime)
    }
    
    func saveMeditation(start: Date, end: Date) {
        let mindfulType = HKCategoryType.categoryType(forIdentifier: .mindfulSession)
        let mindfulSample = HKCategorySample(type: mindfulType!, value: 0, start: start, end: end)
        healthStore.save(mindfulSample) { success, error in
            if(error != nil) {
                print(error.debugDescription)
                abort()
            }else{
                print("Meditation saved!")
            }
        }
    }

}

    
    
    
