//
//  NewsViewController.swift
//  dishvetsovPW4
//
//  Created by Danil Shvetsov on 04.12.2022.
//

import UIKit

// The final class which is the news (article) controller.
final class NewsViewController: UIViewController {
    
    // The image view for the news article.
    private var imageView = UIImageView()
    
    // The title for the news article.
    private var titleLabel = UILabel()
    
    // The description for the news article.
    private var descriptionLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    /// The function which sets up all the UI of controller.
    private func setupUI() {
        view.backgroundColor = CustomColors.set(to: .majorBackgroundDarkGray)
        
        setupNavBar()
        setImageView()
        setTitleLabel()
        setDescriptionLabel()
        setGoBackActionWithRightSwipe()
    }
    
    /// This function sets up the navigation bar of the controller.
    private func setupNavBar() {
        navigationItem.title = "Article"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(goBack)
        )
        navigationItem.leftBarButtonItem?.tintColor = CustomColors.set(to: .minorBackgroundLightOrange)
        navigationController?.navigationBar.barStyle = .black
    }
    
    /// This function sets up the image for the news article.
    private func setImageView() {
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        
        view.addSubview(imageView)
        imageView.pin(to: view, [.left: 0, .right: 0])
        imageView.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        imageView.pinHeight(to: imageView.widthAnchor, 1)
    }
    
    /// This function sets up the title for the news article.
    private func setTitleLabel() {
        titleLabel.font = .systemFont(ofSize: 16, weight: .medium)
        titleLabel.numberOfLines = 0
        titleLabel.textColor = CustomColors.set(to: .majorFontWhite)
        
        view.addSubview(titleLabel)
        titleLabel.pinTop(to: imageView.bottomAnchor, 8)
        titleLabel.pin(to: view, [.left: 16, .right: 16])
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 16).isActive = true
    }
    
    /// This function sets up the description for the news article.
    private func setDescriptionLabel() {
        descriptionLabel.font = .systemFont(ofSize: 14, weight: .regular)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .lightGray
        
        view.addSubview(descriptionLabel)
        descriptionLabel.pin(to: view, [.left: 16, .right: 16])
        descriptionLabel.pinTop(to: titleLabel.bottomAnchor, 8)
    }
    
    /// This function sets up the action of right swipe for returning to the previous contorller.
    private func setGoBackActionWithRightSwipe() {
        let rightGesture = UISwipeGestureRecognizer(
            target: self,
            action: #selector(swipeActionBackToChats)
        )
        rightGesture.direction = .right
            
        self.view.addGestureRecognizer(rightGesture)
    }
    
    /// This function handles the process of right swipe for returning to the previous controller.
    /// - Parameter sender: Sender.
    @objc
    private func swipeActionBackToChats(_ sender: UISwipeGestureRecognizer) {
        self.navigationController?.fadeOut()
    }
    
    /// This function configures the data for the controller from the cell.
    /// - Parameter viewModel: View model which observes the updates for the data.
    public func configure(with viewModel: NewsViewModel) {
        titleLabel.text = viewModel.title
        
        descriptionLabel.text = viewModel.description
        
        if let data = viewModel.imageData {
            imageView.image = UIImage(data: data)
        }
        else if let url = viewModel.imageURL {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data else {
                    return
                }
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(data: data)
                }
            }.resume()
        } else {
            imageView.image = UIImage(named: "mountains_default")
        }
    }
    
    /// This function describes the action of returning to the previous controller after pressing go back button.
    @objc
    func goBack() {
        self.navigationController?.fadeOut()
    }
}
