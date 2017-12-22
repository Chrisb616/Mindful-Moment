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
    @IBOutlet weak var meditateButton: UIButton!
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
        
        print("Memory warning in MenuViewController")
    }
    
    //MARK: - Formatting
    func formatFromNib() {
        meditateButton.standardFormat()
        sessionsButton.standardFormat()
        settingsButton.standardFormat()
        appInfoButton.standardFormat()
    }
    
    //MARK: - IBActions
    
    @IBAction func meditateButtonTouchUpInside(_ sender: Any) {
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
