//
//  TimerViewController.swift
//  Mindful Moment
//
//  Created by Christopher Boynton on 12/20/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var timeDuration: UILabel!
    @IBOutlet weak var beginMeditationButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    //MARK: - References
    var meditationTimer: MeditationTimer { return MeditationTimer.instance }
    
    //MARK: - Initialization
    static var instanceFromNib: TimerViewController {
        return TimerViewController(nibName: "TimerViewController", bundle: Bundle.main)
    }

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        formatFromNib()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        print("Memory warning in TimerViewController")
    }
    
    //MARK: - Format
    func formatFromNib() {
        beginMeditationButton.standardFormat()
        backButton.standardFormat()
    }
    
    //MARK: - Timer
    func beginTimer() {
        
        meditationTimer.begin()
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            self.updateTimeDurationLabel()
        }
    }
    
    func updateTimeDurationLabel() {
        self.timeDuration.text = meditationTimer.currentDuration?.timeCodeFormat
    }
    
    //MARK: - Actions
    @IBAction func beginMeditationTouchUpInside(_ sender: Any) {
        beginTimer()
    }
    
    @IBAction func backButtonTouchUpInside(_ sender: Any) {
        dismiss(animated: true) {
            NotificationManager.instance.postShowMenuViewControllerNotification()
        }
    }
}
