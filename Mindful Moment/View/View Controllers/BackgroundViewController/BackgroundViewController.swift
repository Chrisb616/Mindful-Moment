//
//  BackgroundViewController.swift
//  Mindful Moment
//
//  Created by Christopher Boynton on 12/20/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import UIKit

class BackgroundViewController: UIViewController {
    
    var isFirstLoad = true
    
    static var instanceFromNib: BackgroundViewController {
        return BackgroundViewController(nibName: "BackgroundViewController", bundle: Bundle.main)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNotifications()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if isFirstLoad {
            isFirstLoad = false
            presentMenuViewController()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpNotifications() {
        let notificationManager = NotificationManager.instance
        
        notificationManager.setShowMenuViewControllerObserver(observer: self, selector: #selector(presentMenuViewController))
        notificationManager.setShowTimerViewControllerObserver(observer: self, selector: #selector(presentTimerViewController))
        notificationManager.setShowSessionsViewControllerObserver(observer: self, selector: #selector(presentSessionsViewController))
        notificationManager.setShowSettingsViewControllerObserver(observer: self, selector: #selector(presentSettingsViewController))
        notificationManager.setShowAppInfoViewControllerObserver(observer: self, selector: #selector(presentAppInfoViewController))
    }
    
    @objc func presentMenuViewController() {
        let menu = MenuViewController.instanceFromNib
        menu.modalPresentationStyle = .overCurrentContext
        present(menu, animated: true, completion: nil)
    }
    
    @objc func presentTimerViewController() {
        let timer = TimerViewController.instanceFromNib
        timer.modalPresentationStyle = .overCurrentContext
        present(timer, animated: true, completion: nil)
    }
    
    @objc func presentSessionsViewController() {
        let sessions = SessionsViewController.instanceFromNib
        present(sessions, animated: true, completion: nil)
    }
    
    @objc func presentSettingsViewController() {
        let settings = SettingsViewController.instanceFromNib
        settings.modalPresentationStyle = .overCurrentContext
        present(settings, animated: true, completion: nil)
    }

    @objc func presentAppInfoViewController() {
        let appInfo = AppInfoViewController.instanceFromNib
        appInfo.modalPresentationStyle = .overCurrentContext
        present(appInfo, animated: true, completion: nil)
    }
}
