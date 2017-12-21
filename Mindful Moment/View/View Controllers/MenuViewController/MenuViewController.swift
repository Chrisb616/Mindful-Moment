//
//  MenuViewController.swift
//  Mindful Moment
//
//  Created by Christopher Boynton on 12/18/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var sessionsButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var appInfoButton: UIButton!
    
    //MARK: - Initialization
    static var instanceFromNib: MenuViewController {
        return MenuViewController(nibName: "MenuViewController", bundle: Bundle.main)
    }

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        formatFromNib()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("Memory warning in MenuViewController")
    }
    
    //MARK: - Formatting
    func formatFromNib() {
        startButton.layer.cornerRadius = 5
        startButton.layer.borderWidth = 3
        startButton.layer.borderColor = Colors.purple.cgColor
        
        sessionsButton.layer.cornerRadius = 5
        sessionsButton.layer.borderWidth = 3
        sessionsButton.layer.borderColor = Colors.purple.cgColor
        
        settingsButton.layer.cornerRadius = 5
        settingsButton.layer.borderWidth = 3
        settingsButton.layer.borderColor = Colors.purple.cgColor
        
        appInfoButton.layer.cornerRadius = 5
        appInfoButton.layer.borderWidth = 3
        appInfoButton.layer.borderColor = Colors.purple.cgColor
    }
    
    //MARK: - IBActions
    
    @IBAction func startButtonTouchUpInside(_ sender: Any) {
        dismiss(animated: true) {
            NotificationManager.instance.postShowTimerViewControllerNotification()
        }
    }
    @IBAction func sessionsButtonTouchUpInside(_ sender: Any) {
        dismiss(animated: true) {
            NotificationManager.instance.postShowSessionsViewControllerNotification()
        }
    }
    @IBAction func settingsButtonTouchUpInside(_ sender: Any) {
        dismiss(animated: true) {
            NotificationManager.instance.postShowSettingsViewControllerNotification()
        }
    }
    @IBAction func appInfoButtonTouchUpInside(_ sender: Any) {
        dismiss(animated: true) {
            NotificationManager.instance.postShowAppInfoViewControllerNotification()
        }
    }
    
    
}
