//
//  SessionsTableViewCell.swift
//  Mindful Moment
//
//  Created by Christopher Boynton on 12/22/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import UIKit

class SessionsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var minutesLabel: UILabel!
    
    var session: Session!
    
    //MARK: - Static Reference Properties
    static var nib: UINib {
        return UINib(nibName: "SessionsTableViewCell", bundle: Bundle.main)
    }
    
    static var identifier = "SessionsTableViewCell"

    //MARK: - Formatting
    func format(for session: Session) {
        
        self.session = session
        
        dateLabel.text = session.startDate.formatted(as: "MM/dd/yy")
        timeLabel.text = session.startDate.formatted(as: "hh:mma")
        minutesLabel.text = session.duration.timeUnitFormat
        
        selectionStyle = .none
        
    }
    
}
