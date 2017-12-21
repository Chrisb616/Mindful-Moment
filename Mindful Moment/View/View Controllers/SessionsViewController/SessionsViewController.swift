//
//  SessionsViewController.swift
//  Mindful Moment
//
//  Created by Christopher Boynton on 12/20/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import UIKit

class SessionsViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var backButton: UIButton!
    
    //MARK: - Initialization
    static var instanceFromNib: SessionsViewController {
        return SessionsViewController(nibName: "SessionsViewController", bundle: Bundle.main)
    }

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        formatFromNib()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("Memory warning in SessionsViewController")
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
