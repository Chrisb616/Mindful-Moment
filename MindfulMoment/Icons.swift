//
//  Icons.swift
//  MindfulMoment
//
//  Created by Christopher Boynton on 12/20/16.
//  Copyright © 2016 Christopher. All rights reserved.
//

import UIKit

struct Icon {
    
    enum Library: String {
        case info = "\u{f05a}"
    }
    
    enum Size {
        case medium
        
        var font: UIFont {
            switch self {
            case .medium: return UIFont(name: "FontAwesome", size: 40)!
            }
        }
    }
}
