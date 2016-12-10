//
//  SessionsViewController.swift
//  Flatiron Presents Health Kit App
//
//  Created by Christopher Boynton on 11/15/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class SessionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let store = DataStore.sharedInstance

    @IBOutlet weak var tableView: UITableView!
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        store.getMeditationsFromHeath {
            self.tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Here")
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.sessions.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SessionCell", for: indexPath)
        
        
        cell.textLabel?.text = store.sessions[indexPath.row].startTimeAndDateString
        cell.detailTextLabel?.text = store.sessions[indexPath.row].durationString
        
        return cell
    }

   

}

extension Date {
    func formattedAs(string: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = string
        return dateFormatter.string(from: self)
    }
}
