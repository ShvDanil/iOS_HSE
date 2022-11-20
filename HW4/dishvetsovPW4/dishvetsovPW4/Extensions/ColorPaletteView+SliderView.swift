//
//  ColorPaletteView+SliderView.swift
//  dishvetsovPW4
//
//  Created by Danil Shvetsov on 25.10.2022.
//

import UIKit

// Extension for color palette view which defines the behavior of each slider.
extension ColorPaletteView {
    internal final class ColorSliderView: UIControl {
        private let slider = UISlider()
        private let colorLabel = UILabel()
        
        private(set) var value: Float
        
        init(colorName: String, value: Float) {
            self.value = value
            super.init(frame: .zero)
            
            slider.value = value
            colorLabel.text = colorName
            colorLabel.textColor = CustomColors.set(to: .majorFontWhite)
            setupView()
            slider.addTarget(
                self,
                action: #selector(sliderMoved(_:)),
                for: .touchDragInside
            )
        }
        
        @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        /// Executes the setup process for stack of sliders.
        private func setupView() {
            let stackView = UIStackView(arrangedSubviews: [colorLabel, slider])
            stackView.axis = .horizontal
            stackView.spacing = 8
            
            // Setting the position of stack of sliders and pin them.
            addSubview(stackView)
            stackView.pinLeft(to: self, 12)
            stackView.pinTop(to: self, 12)
            stackView.pinRight(to: self, 12)
            stackView.pinBottom(to: self, 12)
        }
        
        /// Changes the value of slider according to its' position.
        /// - Parameter slider: Red or green or blue slider.
        @objc
        private func sliderMoved(_ slider: UISlider) {
            self.value = slider.value
            sendActions(for: .touchDragInside)
        }
    }
}
