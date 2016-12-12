//
//  UIView.swift
//  MindfulMoment
//
//  Created by Christopher Boynton on 12/12/16.
//  Copyright © 2016 Christopher. All rights reserved.
//

import UIKit

extension UIView {
    
    func addFittedSubview(_ view: UIView, multiplier: CGFloat = 1) {
        self.addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        view.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        view.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: multiplier).isActive = true
        view.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: multiplier).isActive = true
    }
    
}
