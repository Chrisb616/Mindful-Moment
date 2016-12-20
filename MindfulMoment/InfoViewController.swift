//
//  InfoView.swift
//  MindfulMoment
//
//  Created by Christopher Boynton on 12/20/16.
//  Copyright © 2016 Christopher. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    
    var okButton = UIButton()
    var okLabel = UILabel()
    
    var tutorialTextView = UITextView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.themeTeal
        
        self.view.addSubview(okButton)
        okButton.backgroundColor = UIColor.themePurple
        okButton.frame = CGRect(x: self.view.frame.width * 0.4, y: self.view.frame.height * 0.85, width: self.view.frame.width * 0.2, height: self.view.frame.width * 0.2)
        okButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        okButton.addFittedSubview(okLabel)
        okButton.layer.cornerRadius = 15
        
        okLabel.text = "OK"
        okLabel.font = UIFont.smallTextFont
        okLabel.textColor = UIColor.themeTeal
        okLabel.textAlignment = .center
        
        self.view.addSubview(tutorialTextView)
        tutorialTextView.frame = CGRect(x: self.view.frame.width * 0.1, y: self.view.frame.height * 0.1, width: self.view.frame.width * 0.8, height: self.view.frame.height * 0.7)
        tutorialTextView.backgroundColor = nil
        tutorialTextView.isEditable = false
        tutorialTextView.font = UIFont(name: "AvenirNext", size: 12)
        tutorialTextView.text = "Mindful Moment is here to help you record your meditations, keeping track of them on your device's Health App. Pressing Start will begin the timer, and pressing Stop will end it and record the session.\n\n\n\nDeveloped by Christopher Boynton\n\ngithub.com/Chrisb616\n\n\n\n\nSPECIAL THANKS:\nMissy Allan\nStudents and Instructors at the Flatiron School\n\n\n\nMusic by Lee Rosevere\nfreemusicarchive.org/music/Lee_Rosevere"
        
        
    }
    func dismissVC() {
        dismiss(animated: true)
    }
}
