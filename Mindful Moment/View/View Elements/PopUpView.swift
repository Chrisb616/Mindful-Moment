//
//  TimerCompletionView.swift
//  Mindful Moment
//
//  Created by Christopher Boynton on 1/26/18.
//  Copyright © 2018 Christopher Boynton. All rights reserved.
//

import UIKit

class PopUpView: UIView {
    
    static var instanceFromNib: PopUpView {
        return UINib(nibName: "PopUpView", bundle: Bundle.main).instantiate(withOwner: self, options: nil).first as! PopUpView
    }

}
