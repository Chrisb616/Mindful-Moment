//
//  AppInfoViewController.swift
//  Mindful Moment
//
//  Created by Christopher Boynton on 12/20/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import UIKit

class AppInfoViewController: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var versionLabel: UILabel!
    
    
    @IBOutlet weak var backButton: UIButton!
    
    static var instanceFromNib: AppInfoViewController {
        return AppInfoViewController(nibName: "AppInfoViewController", bundle: Bundle.main)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
        formatFromNib()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("Memory warning in AppInfoViewController")
    }
    
    //MARK: - Format
    func formatFromNib() {
        contentView.standardFormat()
        
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] {
            versionLabel.text = "Mindful Moment v\(version)"
        }
        
        backButton.standardFormat()
    }
    
    //MARK: - IB Actions
    @IBAction func backButtonTouchUpInside(_ sender: Any) {
        dismiss(animated: true) {
            NotificationManager.instance.postShowMenuViewControllerNotification()
        }
    }
}
