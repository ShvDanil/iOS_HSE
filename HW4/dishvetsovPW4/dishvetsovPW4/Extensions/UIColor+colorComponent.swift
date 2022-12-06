//
//  UIColor+colorComponent.swift
//  dishvetsovPW4
//
//  Created by Danil Shvetsov on 26.10.2022.
//

import UIKit

// Extension for UIColor which adds the ability to get rgb color component.
extension UIColor {
    
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        return (red, green, blue, alpha)
    }
    
    static var gradientDarkGray: UIColor {
        UIColor(red: 239 / 255.0, green: 241 / 255.0, blue: 241 / 255.0, alpha: 1)
    }
    
    static var gradientLightGray: UIColor {
        UIColor(red: 201 / 255.0, green: 201 / 255.0, blue: 201 / 255.0, alpha: 1)
    }
    
}
