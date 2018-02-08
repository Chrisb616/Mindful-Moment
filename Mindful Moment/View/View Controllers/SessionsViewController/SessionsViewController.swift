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
        sessionsTableView.layer.borderWidth = 2
        sessionsTableView.layer.borderColor = Colors.purple.cgColor
        sessionsTableView.layer.cornerRadius = 5
        
        sessionsTableView.separatorStyle = .none
        
        sessionsTableView.dataSource = self
        sessionsTableView.delegate = self
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
        let cell = tableView.dequeueReusableCell(withIdentifier: SessionsTableViewCell.identifier) as! SessionsTableViewCell
        let session = SessionManager.instance.storedSessions[indexPath.row]
        
        cell.format(for: session)
        
        return cell
    }
}

extension SessionsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            SessionManager.instance.storedSessions.remove(at: indexPath.row)
            
            let cell = tableView.cellForRow(at: indexPath) as! SessionsTableViewCell
            let session = cell.session!
            
            HealthManager.instance.deleteSessionFromStore(session: session, completion: {
                
            })
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
}
