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
    @IBOutlet weak var minutesLabel: UILabel!
    
    //MARK: - Static Reference Properties
    static var nib: UINib {
        return UINib(nibName: "SessionsTableViewCell", bundle: Bundle.main)
    }
    
    static var identifier = "SessionsTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
