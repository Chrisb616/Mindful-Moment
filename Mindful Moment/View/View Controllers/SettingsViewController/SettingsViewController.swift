//
//  SettingsViewController.swift
//  Mindful Moment
//
//  Created by Christopher Boynton on 12/20/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    
    static var instanceFromNib: SettingsViewController {
        return SettingsViewController(nibName: "SettingsViewController", bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        formatFromNib()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("Memory warning in SettingsViewController")
    }
    
    //MARK: - Format
    func formatFromNib() {
        backButton.standardFormat()
    }
    
    //MARK: - IB Actions
    @IBAction func backButtonTouchUpInside(_ sender: Any) {
        dismiss(animated: true) {
            NotificationManager.instance.postShowMenuViewControllerNotification()
        }
    }
}
