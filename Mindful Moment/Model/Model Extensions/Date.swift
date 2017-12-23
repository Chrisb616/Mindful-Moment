//
//  Date.swift
//  Mindful Moment
//
//  Created by Christopher Boynton on 12/22/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import Foundation

extension Date {
    
    func formatted(as string: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = string
        return dateFormatter.string(from: self)
    }
    
}
