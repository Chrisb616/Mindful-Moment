//
//  CGPoint.swift
//  MindfulMoment
//
//  Created by Christopher Boynton on 12/15/16.
//  Copyright © 2016 Christopher. All rights reserved.
//

import UIKit

extension CGPoint {
    
    func isWithin(_ distance: CGFloat, of point: CGPoint) -> Bool {
        let originX = self.x
        let originY = self.y
        
        let destinationX = point.x
        let destinationY = point.y
        
        let a = abs(Int32(originX - destinationX))
        let b = abs(Int32(originY - destinationY))
        
        let cSquared = (a * a) + (b * b)
        
        let c = CGFloat(sqrt(Double(cSquared)))
        
        return c <= distance
    }
}
