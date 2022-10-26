//
//  CALayer+Shadow.swift
//  dishvetsovPW3
//
//  Created by Danil Shvetsov on 25.10.2022.
//

import UIKit

extension CALayer {
    /// Creates shadow for the layer of user interface object with passed values.
    func applyShadow(withColor color: UIColor,
                     withCornerRaduis cornerRadius: CGFloat,
                     withOpacity opacity: Float,
                     withOffset offset: CGSize
    ) {
        self.shadowColor = color.cgColor
        self.cornerRadius = cornerRadius
        self.shadowOpacity = opacity
        self.shadowOffset = offset
    }
}
