//
//  Colors.swift
//  ARTesseract
//
//  Created by Magdusz on 24.04.2018.
//  Copyright © 2018 com.McPusz.ARTesseract. All rights reserved.
//

import UIKit

struct Colors {
    static let first: UIColor = UIColor(red:0.00, green:0.09, blue:0.15, alpha:1.0)
    static let second: UIColor = UIColor(red:0.99, green:1.00, blue:0.99, alpha:1.0)
    static let third: UIColor = UIColor(red:0.18, green:0.77, blue:0.71, alpha:1.0)
    static let fourth: UIColor = UIColor(red:0.91, green:0.11, blue:0.21, alpha:1.0)
    static let fifth: UIColor = UIColor(red:1.00, green:0.62, blue:0.11, alpha:1.0)
    
    static let palette: [UIColor] = [Colors.first, Colors.second, Colors.third, Colors.fourth, Colors.fifth]
    
    static var randomColor: UIColor {
        let randomIndex = Int(arc4random_uniform(UInt32(Colors.palette.count)))
        return self.palette[randomIndex]
    }
}
