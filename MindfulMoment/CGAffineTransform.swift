//
//  CGAffineTransform.swift
//  MindfulMoment
//
//  Created by Christopher Boynton on 12/10/16.
//  Copyright © 2016 Christopher. All rights reserved.
//

import UIKit

extension CGAffineTransform {
    
    init(rotationDegrees: Double) {
        self.init(rotationAngle: rotationDegrees.degreesIntoRadians)
    }
    
}
