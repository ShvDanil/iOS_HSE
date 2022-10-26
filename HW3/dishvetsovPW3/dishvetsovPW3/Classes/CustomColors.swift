//
//  CustomColors.swift
//  dishvetsovPW3
//
//  Created by Danil Shvetsov on 25.10.2022.
//

import UIKit

// Structure for custom colors of project.
struct CustomColors {
    /// Enum of available project colors.
    internal enum Colors {
        case majorBackgroundDarkGray, majorFontWhite, minorBackgroundLightOrange, majorShadowLightGray
    }

    /// Returns the color to set by enum description.
    /// - Parameter color: Enum color description.
    /// - Returns: Color to set.
    internal static func set(to color: Colors) -> UIColor {
        switch color {
        case .majorBackgroundDarkGray:
            return .init(
                red: 27 / 255,
                green: 24 / 255,
                blue: 31 / 255,
                alpha: 1
            )
        case .majorFontWhite:
            return .white
        case .majorShadowLightGray:
            return .init(
                red: 128 / 255,
                green: 128 / 255,
                blue: 128 / 255,
                alpha: 1
            )
        case .minorBackgroundLightOrange:
            return .init(
                red: 230 / 255,
                green: 141 / 255,
                blue: 83 / 255,
                alpha: 1
            )
        }
    }
}

