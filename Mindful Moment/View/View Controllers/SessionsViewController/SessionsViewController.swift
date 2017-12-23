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
    @IBOutlet weak var sessionsTableView: UITableView!
    
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
        
        formatTableView()
    }
    
    func formatTableView() {
        sessionsTableView.dataSource = self
        
        sessionsTableView.register(SessionsTableViewCell.nib, forCellReuseIdentifier: SessionsTableViewCell.identifier)
    }
    
    //MARK: - IB Actions
    @IBAction func backButtonTouchUpInside(_ sender: Any) {
        dismiss(animated: true) {
            NotificationManager.instance.postShowMenuViewControllerNotification()
        }
    }
    
}

extension SessionsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SessionManager.instance.storedSessions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: SessionsTableViewCell? = tableView.dequeueReusableCell(withIdentifier: SessionsTableViewCell.identifier) as? SessionsTableViewCell
    
        cell?.minutesLabel.text = "10 Mins"
        
        return cell!
    }
    
    
    
    
}
