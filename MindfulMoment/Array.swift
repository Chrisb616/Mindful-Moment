//
//  Array.swift
//  MindfulMoment
//
//  Created by Christopher Boynton on 12/13/16.
//  Copyright © 2016 Christopher. All rights reserved.
//

import Foundation

extension Array {
    func randomElement() -> Element {
        return self[Int(arc4random_uniform(UInt32(self.count)))]
    }
}
