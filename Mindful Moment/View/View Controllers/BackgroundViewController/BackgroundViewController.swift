//
//  BackgroundViewController.swift
//  Mindful Moment
//
//  Created by Christopher Boynton on 12/20/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import UIKit

class BackgroundViewController: UIViewController {
    
    //MARK: - Stored Properties
    var isFirstLoad = true
    
    //MARK: View Elements
    
    var centerMountainView: UIImageView!
    var leftMountainView: UIImageView!
    var rightMountainView: UIImageView!
    
    var oceanView: UIView!
    
    //MARK: - Instantiation
    static var instanceFromNib: BackgroundViewController {
        return BackgroundViewController(nibName: "BackgroundViewController", bundle: Bundle.main)
    }

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpInitialBackgroud()
        setUpNotificationObservers()
        
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
    
    //MARK: - View Set Up
    
    func setUpInitialBackgroud() {
        
        let screenRect = UIScreen.main.bounds
        
        // Init
        centerMountainView = UIImageView(image: UIImage.mountain)
        leftMountainView = UIImageView(image: UIImage.mountain)
        rightMountainView = UIImageView(image: UIImage.mountain)
        oceanView = UIView()
        
        // Set Up
        centerMountainView.contentMode = .scaleAspectFill
        leftMountainView.contentMode = .scaleToFill
        rightMountainView.contentMode = .scaleToFill
        oceanView.backgroundColor = Colors.oceanBlue
        
        // Add to Superview
        view.addSubview(oceanView)
        view.addSubview(centerMountainView)
        view.addSubview(leftMountainView)
        view.addSubview(rightMountainView)
        
        // Format
        centerMountainView.frame = CGRect(x: screenRect.origin.x, y: screenRect.height * 0.2, width: screenRect.width, height: screenRect.height * 0.8)
        leftMountainView.frame = CGRect(x: screenRect.width * -0.3, y: screenRect.height * 0.4, width: screenRect.width * 0.9, height: screenRect.height * 0.6)
        rightMountainView.frame = CGRect(x: screenRect.width * 0.4, y: screenRect.height * 0.4, width: screenRect.width * 0.9, height: screenRect.height * 0.6)
        oceanView.frame = CGRect(x: screenRect.origin.x, y: screenRect.height * 0.45, width: screenRect.width, height: screenRect.height * 0.55)
    }
    
    //MARK: - Navigation Observers
    
    func setUpNotificationObservers() {
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
