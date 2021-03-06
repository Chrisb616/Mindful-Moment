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
    
    //MARK - View Properties
    var completionPopUp: PopUpView!
    
    //MARK: - Properties
    var timerIsActive: Bool = false;
    var uiUpdateTimer: Timer?
    
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
    
    //MARK: - Completion Pop Up
    func setUpCompletionPopUp() {
        completionPopUp = PopUpView.present(onView: view, withTitle: "Meditation Complete", body: "Would you like to save this meditation as Mindful Minutes in Health?")
        completionPopUp.formatLeftButton(text: "Don't Save", selector: #selector(closePopUp))
        completionPopUp.formatRightButton(text: "Save", selector: #selector(saveSession))
    }
    
    @objc func closePopUp() {
        completionPopUp.center = CGPoint(x: view.center.x, y: view.center.y + view.frame.height)
        completionPopUp.removeFromSuperview()
        completionPopUp = nil
    }
    
    @objc func saveSession() {
        guard let session = meditationTimer.session else { return }
        
        HealthManager.instance.saveSessionToMindfulMinutes(session: session)
        
        closePopUp()
    }
    
    //MARK: - Timer
    func beginTimer() {
        meditationTimer.begin()
        
        timerIsActive = true
        
        beginMeditationButton.setTitle("End Meditation", for: .normal)
        backButton.isHidden = true
        
        uiUpdateTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            self.updateTimeDurationLabel()
        }
    }
    
    func finishTimer() {
        meditationTimer.finish()
        
        timerIsActive = false
        
        uiUpdateTimer?.invalidate()
        uiUpdateTimer = nil
        
        beginMeditationButton.setTitle("Begin Meditation", for: .normal)
        backButton.isHidden = false
        
        setUpCompletionPopUp()
    }
    
    func updateTimeDurationLabel() {
        self.timeDuration.text = meditationTimer.currentDuration?.timeCodeFormat
    }
    
    //MARK: - IB Actions
    @IBAction func beginMeditationTouchUpInside(_ sender: Any) {
        if timerIsActive {
            finishTimer()
        } else {
            beginTimer()
        }
    }
    
    @IBAction func backButtonTouchUpInside(_ sender: Any) {
        dismiss(animated: true) {
            NotificationManager.instance.postDidDismissTimerViewControllerNotification()
            NotificationManager.instance.postShowMenuViewControllerNotification()
        }
    }

}
