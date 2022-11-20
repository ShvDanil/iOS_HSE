//
//  ColorPaletteView.swift
//  dishvetsovPW4
//
//  Created by Danil Shvetsov on 25.10.2022.
//

import UIKit

// Class which describes the functionality of color palette view.
final class ColorPaletteView: UIControl {
    private let stackView = UIStackView()
    private(set) var chosenColor: UIColor = CustomColors.set(to: .minorBackgroundLightOrange)
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /// Executes the setup of view with all defined settings.
    private func setupView() {
        // Here defined settings for red control slider.
        let redControl = ColorSliderView(colorName: "R", value: Float(chosenColor.rgba.red))
        redControl.tintColor = CustomColors.set(to: .majorFontWhite)
        redControl.tag = 0
        
        // Here defined settings for green control slider.
        let greenControl = ColorSliderView(colorName: "G", value: Float(chosenColor.rgba.green))
        greenControl.tintColor = CustomColors.set(to: .majorFontWhite)
        greenControl.tag = 1
        
        // Here defined settings for blue control slider.
        let blueControl = ColorSliderView(colorName: "B", value: Float(chosenColor.rgba.blue))
        blueControl.tintColor = CustomColors.set(to: .majorFontWhite)
        blueControl.tag = 2
        
        // Here defined settings for stackView.
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubview(redControl)
        stackView.addArrangedSubview(greenControl)
        stackView.addArrangedSubview(blueControl)
        stackView.backgroundColor = CustomColors.set(to: .minorBackgroundLightOrange)
        stackView.layer.cornerRadius = 12
        
        // Added target for processing color by slider's current value.
        [redControl, greenControl, blueControl].forEach {
            $0.addTarget(
                self,
                action: #selector(sliderMoved(slider:)),
                for: .touchDragInside
            )
        }
        
        // Defined position of stackView and pinned it.
        self.addSubview(stackView)
        stackView.pin(to: self)
    }
    
    /// Handles the process of slider movement and changes chosen color.
    /// - Parameter slider: Red or green or blue slider.
    @objc
    private func sliderMoved(slider: ColorSliderView) {
        switch slider.tag {
        case 0:
            self.chosenColor = UIColor(
                red: CGFloat(slider.value),
                green: chosenColor.rgba.green,
                blue: chosenColor.rgba.blue,
                alpha: chosenColor.rgba.alpha
            )
        case 1:
            self.chosenColor = UIColor(
                red: chosenColor.rgba.red,
                green: CGFloat(slider.value),
                blue: chosenColor.rgba.blue,
                alpha: chosenColor.rgba.alpha
            )
        default:
            self.chosenColor = UIColor(
                red: chosenColor.rgba.red,
                green: chosenColor.rgba.green,
                blue: CGFloat(slider.value),
                alpha: chosenColor.rgba.alpha
            )
        }
        sendActions(for: .touchDragInside)
    }
}
