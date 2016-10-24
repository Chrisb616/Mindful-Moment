//
//  ViewController.swift
//  Flatiron Presents Health Kit App
//
//  Created by Christopher Boynton on 10/24/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var backgroundColor01 = UIColor.init(red: 143/255, green: 201/255, blue: 185/255, alpha: 1)
    var backgroundColor02 = UIColor.init(red: 216/255, green: 217/255, blue: 192/255, alpha: 1)
    var backgroundColor03 = UIColor.init(red: 209/255, green: 142/255, blue: 143/255, alpha: 1)
    var backgroundColor04 = UIColor.init(red: 171/255, green: 92/255, blue: 114/255, alpha: 1)
    var backgroundColor05 = UIColor.init(red: 145/255, green: 51/255, blue: 79/255, alpha: 1)
    var backgroundColor06 = UIColor()
    var backgroundColor07 = UIColor()
    var backgroundColor08 = UIColor()
    var backgroundColor09 = UIColor()
    var backgroundColor10 = UIColor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIView.animateKeyframes(withDuration: 30, delay: 0, options: .calculationModeCubic, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/6, animations: {
                self.view.backgroundColor = self.backgroundColor01
            })
            UIView.addKeyframe(withRelativeStartTime: 1/6, relativeDuration: 1/6, animations: {
                self.view.backgroundColor = self.backgroundColor02
            })
            UIView.addKeyframe(withRelativeStartTime: 2/6, relativeDuration: 1/6, animations: {
                self.view.backgroundColor = self.backgroundColor03
            })
            UIView.addKeyframe(withRelativeStartTime: 3/6, relativeDuration: 1/6, animations: {
                self.view.backgroundColor = self.backgroundColor04
            })
            UIView.addKeyframe(withRelativeStartTime: 4/6, relativeDuration: 1/6, animations: {
                self.view.backgroundColor = self.backgroundColor05
            })
            }, completion: nil)
        
    }
    


}

