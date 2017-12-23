//
//  NotificationManager.swift
//  Mindful Moment
//
//  Created by Christopher Boynton on 12/19/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import Foundation

class NotificationManager {
    
    private init() {}
    static let instance = NotificationManager()
    
    private let notificationCenter = NotificationCenter.default
    
    //MARK: - Names
    private var startTimerName = Notification.Name("StartTimer")
    private var endTimerName = Notification.Name("EndTimer")
    
    private var showMenuViewControllerName = Notification.Name("ShowMenu")
    private var showTimerViewControllerName = Notification.Name("ShowTimer")
    private var showSessionsViewControllerName = Notification.Name("ShowSessions")
    private var showSettingsViewControllerName = Notification.Name("ShowSettings")
    private var showAppInfoViewControllerName = Notification.Name("ShowAppInfo")
    
    //MARK: - Add Observers
    func setStartTimerObserver(observer: Any, selector: Selector) {
        notificationCenter.addObserver(observer, selector: selector, name: startTimerName, object: nil)
    }
    
    func setEndTimerObserver(observer: Any, selector: Selector) {
        notificationCenter.addObserver(observer, selector: selector, name: endTimerName, object: nil)
    }
    
    func setShowMenuViewControllerObserver(observer: Any, selector: Selector) {
        notificationCenter.addObserver(observer, selector: selector, name: showMenuViewControllerName, object: nil)
    }
    
    func setShowTimerViewControllerObserver(observer: Any, selector: Selector) {
        notificationCenter.addObserver(observer, selector: selector, name: showTimerViewControllerName, object: nil)
    }
    
    func setShowSessionsViewControllerObserver(observer: Any, selector: Selector) {
        notificationCenter.addObserver(observer, selector: selector, name: showSessionsViewControllerName, object: nil)
    }
    
    func setShowSettingsViewControllerObserver(observer: Any, selector: Selector) {
        notificationCenter.addObserver(observer, selector: selector, name: showSettingsViewControllerName, object: nil)
    }
    
    func setShowAppInfoViewControllerObserver(observer: Any, selector: Selector) {
        notificationCenter.addObserver(observer, selector: selector, name: showAppInfoViewControllerName, object: nil)
    }
    
    //MARK: - Post Notification
    func postStartTimerNotification() {
        notificationCenter.post(name: startTimerName, object: nil)
    }
    
    func postEndTimerNotification(saveSession: Bool) {
        notificationCenter.post(name: endTimerName, object: nil, userInfo: ["saveSession":saveSession])
    }
    
    func postShowMenuViewControllerNotification() {
        notificationCenter.post(name: showMenuViewControllerName, object: nil)
    }
    
    func postShowTimerViewControllerNotification() {
        notificationCenter.post(name: showTimerViewControllerName, object: nil)
    }
    
    func postShowSessionsViewControllerNotification() {
        notificationCenter.post(name: showSessionsViewControllerName, object: nil)
    }
    
    func postShowSettingsViewControllerNotification() {
        notificationCenter.post(name: showSettingsViewControllerName, object: nil)
    }
    
    func postShowAppInfoViewControllerNotification() {
        notificationCenter.post(name: showAppInfoViewControllerName, object: nil)
    }

}
