//
//  Double.swift
//  MindfulMoment
//
//  Created by Christopher Boynton on 12/10/16.
//  Copyright © 2016 Christopher. All rights reserved.
//

import UIKit

extension Double {
    var degreesIntoRadians: CGFloat { return CGFloat(M_PI * self) / 180 }
}
