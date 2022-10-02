//
//  WelcomeViewController.swift
//  dishvetsovPW2
//
//  Created by Danil Shvetsov on 02.10.2022.
//

import UIKit

// WelcomeViewController class describing main window.
final class WelcomeViewController: UIViewController {
    // Main user interface components of controller.
    private let commentLabel: UILabel = UILabel()
    private let commentView: UIView = UIView()
    private let valueLabel: UILabel = UILabel()
    private let incrementButton: UIButton = UIButton()
    
    private var value: Int = 0
    
    /// Main setup of controller.
    private func setupView() {
        initApplicationBackgroundColor()
        setupIncrementButton()
        setupValueLabel()
        setupCommentView()
        setupCommentLabel()
        setupMenuButtons()
    }
    
    /// Setup of increment button.
    private func setupIncrementButton() {
        setupIncrementButtonAppearance()
        setupIncrementButtonPosition()
        setupIncrementButtonActions()
    }
    
    /// Setup of appearance of increment button.
    private func setupIncrementButtonAppearance() {
        incrementButton.setTitle(
            "press me",
            for: .normal
        )
        incrementButton.setTitleColor(
            CustomColors.set(to: .majorFontWhite),
            for: .normal
        )
        incrementButton.layer.cornerRadius = 12
        incrementButton.titleLabel?.font = .systemFont(
            ofSize: 20.0,
            weight: .medium
        )
        incrementButton.backgroundColor = CustomColors.set(to: .minorBackgroundLightOrange)
        incrementButton.layer.applyShadow(
            withColor: CustomColors.set(to: .majorShadowLightGray),
            withCornerRaduis: 12.0,
            withOpacity: 1.0,
            withOffset: .zero
        )
    }
    
    /// Setup of position of increment button on main screen controller.
    private func setupIncrementButtonPosition() {
        self.view.addSubview(incrementButton)
        incrementButton.setHeight(to: 48)
        incrementButton.pinTop(to: self.view.centerYAnchor)
        incrementButton.pinLeft(to: self.view, 24)
        incrementButton.pinRight(to: self.view, 24)
    }
    
    /// Setup of actions ocurring by press of increment button.
    private func setupIncrementButtonActions() {
        incrementButton.addTarget(
            self,
            action: #selector(incrementButtonPressed),
            for: .touchUpInside
        )
    }
    
    /// Setup of value label.
    private func setupValueLabel() {
        setupValueLabelAppearance()
        setupValueLabelPosition()
    }
    
    /// Setup of appearance of value label.
    private func setupValueLabelAppearance() {
        valueLabel.font = .systemFont(
            ofSize: 45.0,
            weight: .bold
        )
        valueLabel.textColor = CustomColors.set(to: .majorFontWhite)
        valueLabel.text = "\(value)"
    }
    
    /// Setup of position of value label on main screen controller.
    private func setupValueLabelPosition() {
        self.view.addSubview(valueLabel)
        valueLabel.pinBottom(
            to: incrementButton.topAnchor,
            16
        )
        valueLabel.pinCenterX(to: self.view.centerXAnchor)
    }
    
    /// Returns the user interface view.
    /// - Returns: UIView.
    @discardableResult
    private func setupCommentView() -> UIView {
        setupCommentViewAppearance()
        setupCommentViewPosition()
        
        return commentView
    }
    
    /// Setup the appearance of comment view.
    private func setupCommentViewAppearance() {
        commentView.backgroundColor = CustomColors.set(to: .minorBackgroundLightOrange)
        commentView.layer.cornerRadius = 12
        commentView.layer.applyShadow(
            withColor: CustomColors.set(to: .majorShadowLightGray),
            withCornerRaduis: 12.0,
            withOpacity: 1.0,
            withOffset: .zero
        )
    }
    
    /// Setup of position of comment view on main screen controller.
    private func setupCommentViewPosition() {
        self.view.addSubview(commentView)
        commentView.pinTop(to: self.view.safeAreaLayoutGuide.topAnchor)
        commentView.pinLeft(
            to: self.view,
            24
        )
        commentView.pinRight(
            to: self.view,
            24
        )
    }
    
    /// Setup of comment label.
    private func setupCommentLabel() {
        setupCommentLabelAppearance()
        setupCommentLabelPosition()
    }
    
    /// Setup of appearance of comment label.
    private func setupCommentLabelAppearance() {
        commentLabel.font = .systemFont(
            ofSize: 14.0,
            weight: .regular
        )
        commentLabel.textColor = CustomColors.set(to: .majorFontWhite)
        commentLabel.numberOfLines = 0
        commentLabel.textAlignment = .center
        commentLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
    }
    
    /// Setup of position of comment label on main screen controller.
    private func setupCommentLabelPosition() {
        commentView.addSubview(commentLabel)
        commentLabel.pinTop(
            to: commentView,
            16
        )
        commentLabel.pinLeft(
            to: commentView,
            16
        )
        commentLabel.pinBottom(
            to: commentView,
            16
        )
        commentLabel.pinRight(
            to: commentView,
            16
        )
    }
    
    /// Setup of menu buttons.
    private func setupMenuButtons() {
        // Declaration of three main colors.
        let colorsButton: UIButton = makeMenuButton(title: "🎨")
        let notesButton: UIButton = makeMenuButton(title: "📝")
        let newsButton: UIButton = makeMenuButton(title: "📰")
        
        // Declaration of stack view with three main buttons.
        let buttonsSV: UIStackView = UIStackView(arrangedSubviews: [colorsButton, notesButton, newsButton])
        buttonsSV.spacing = 12
        buttonsSV.axis = .horizontal
        buttonsSV.distribution = .fillEqually
        
        // Set of position of subview with three main buttons.
        self.view.addSubview(buttonsSV)
        buttonsSV.pinLeft(
            to: self.view,
            24
        )
        buttonsSV.pinRight(
            to: self.view,
            24
        )
        buttonsSV.pinBottom(
            to: self.view.safeAreaLayoutGuide.bottomAnchor,
            24
        )
    }
    
    /// Returns the user interface button.
    /// - Parameter title: Title described on button.
    /// - Returns: The UIButton.
    @discardableResult
    private func makeMenuButton(title: String) -> UIButton {
        let button: UIButton = UIButton()
        setupMenuButtonAppearance(
            for: button,
               with: title
        )
        setupMenuButtonPosition(for: button)
        return button
    }
    
    /// Setup of appearance of menu button.
    /// - Parameters:
    ///   - button: Button for setting the appearance.
    ///   - title: Title described on button.
    private func setupMenuButtonAppearance(for button: UIButton, with title: String) {
        button.setTitle(
            title,
            for: .normal
        )
        button.setTitleColor(
            CustomColors.set(to: .majorFontWhite),
            for: .normal
        )
        button.layer.cornerRadius = 12
        button.layer.applyShadow(
            withColor: CustomColors.set(to: .majorShadowLightGray),
            withCornerRaduis: 12.0,
            withOpacity: 1.0,
            withOffset: .zero
        )
        button.titleLabel?.font = .systemFont(
            ofSize: 25.0,
            weight: .medium
        )
        button.backgroundColor = CustomColors.set(to: .minorBackgroundLightOrange)
    }
    
    /// Setup of position of each menu button.
    /// - Parameter button: Button for setting the appearance.
    private func setupMenuButtonPosition(for button: UIButton) {
        button.heightAnchor.constraint(
            equalTo: button.widthAnchor
        ).isActive = true
    }
    
    /// Initialization of main screen (WelcomeView) background color.
    private func initApplicationBackgroundColor() {
        self.view.backgroundColor = CustomColors.set(to: .majorBackgroundDarkGray)
    }
    
    /// Action which handles the event of press of increment button.
    @objc
    private func incrementButtonPressed() {
        value += 1
        
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        
        UIView.animate(withDuration: 0.25, delay: 0.07, animations: {
            self.updateUI()
            self.updateCommentLabelText(self.value)
            self.incrementButton.backgroundColor = CustomColors.set(to: .minorBackgroundLightOrange)
            self.commentView.backgroundColor = CustomColors.set(to: .minorBackgroundLightOrange)
        })
    }
    
    /// The update of user interface during incement button press action.
    private func updateUI() {
        incrementButton.backgroundColor = CustomColors.set(to: .majorBackgroundDarkGray)
        valueLabel.text = "\(value)"
    }
    
    /// Updates text of comment label according to current value.
    /// - Parameter value: Current value of label.
    private func updateCommentLabelText(_ value: Int) {
        if value == 1 || value % 10 == 0 {
            commentView.backgroundColor = CustomColors.set(to: .majorBackgroundDarkGray)
        }
        switch value {
        case 0..<10:
            commentLabel.text = "🎉 1 level! 🎉"
        case 10..<20:
            commentLabel.text = "🎉 2 level! 🎉"
        case 20..<30:
            commentLabel.text = "🎉 3 level! 🎉"
        case 30..<40:
            commentLabel.text = "🎉 4 level! 🎉"
        case 40..<50:
            commentLabel.text = "🎉🎉🎉🎉🎉 5 level! 🎉🎉🎉🎉🎉"
        case 50..<60:
            commentLabel.text = "🎉🎉 big boy level! 🎉🎉"
        case 60..<70:
            commentLabel.text = "🎉 70 70 70 moreeeee! 🎉"
        case 70..<80:
            commentLabel.text = "⭐️⭐️⭐️🎉⭐️⭐️⭐️🎉⭐️⭐️⭐️"
        case 80..<90:
            commentLabel.text = "80+\n go higher! 🎉⭐️⭐️⭐️"
        case 90..<100:
            commentLabel.text = "100!! to the moon!!"
        default:
            break
        }
    }
    
    /// The load of WelcomeView on the screen of application.
    internal override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}
