//
//  TimerViewController.swift
//  Mindful Moment
//
//  Created by Christopher Boynton on 12/20/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {
    
    //MARK: - Initialization
    static var instanceFromNib: TimerViewController {
        return TimerViewController(nibName: "TimerViewController", bundle: Bundle.main)
    }

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("Memory warning in TimerViewController")
    }
    
    //MARK: - Format
    func formatFromNib() {
        
    }
    
}
