//
//  NewsCell.swift
//  dishvetsovPW4
//
//  Created by Danil Shvetsov on 03.12.2022.
//

import UIKit

// The final class for the news cell.
final class NewsCell: UITableViewCell {
    
    // Identifier for registration of notes view controller.
    static let reuseIdentifier = "NewsCell"
    
    // The image for the news cell.
    private let newsImageView = UIImageView()
    
    // The title for the news cell.
    private let newsTitleLabel = UILabel()
    
    // The description for the news cell.
    private let newsDescriptionLabel = UILabel()
    
    // MARK: - Init.
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    /// This function sets the UI view appearance and position.
    private func setupView() {
        contentView.backgroundColor = CustomColors.set(to: .majorBackgroundDarkGray)
        
        setupImageView()
        setupTitleLabel()
        setupDescriptionLabel()
    }
    
    /// This function sets up the image view for the cell.
    private func setupImageView() {
        newsImageView.layer.cornerRadius = 8
        newsImageView.layer.cornerCurve = .continuous
        newsImageView.clipsToBounds = true
        newsImageView.contentMode = .scaleAspectFill
        newsImageView.backgroundColor = .secondarySystemBackground
        
        contentView.addSubview(newsImageView)
        newsImageView.translatesAutoresizingMaskIntoConstraints = false
        newsImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12).isActive = true
        newsImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        newsImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12).isActive = true
        newsImageView.pinWidth(to: newsImageView.heightAnchor)
    }
    
    /// This function sets up the title label for the cell.
    private func setupTitleLabel() {
        newsTitleLabel.font = .systemFont(ofSize: 16, weight: .medium)
        newsTitleLabel.textColor = CustomColors.set(to: .majorFontWhite)
        newsTitleLabel.numberOfLines = 1
        
        contentView.addSubview(newsTitleLabel)
        newsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        newsTitleLabel.heightAnchor.constraint(equalToConstant: newsTitleLabel.font.lineHeight).isActive = true
        newsTitleLabel.leadingAnchor.constraint(equalTo: newsImageView.trailingAnchor, constant: 12).isActive = true
        newsTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12).isActive = true
        newsTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12).isActive = true
    }
    
    /// This function sets up the description label for the cell.
    private func setupDescriptionLabel() {
        newsDescriptionLabel.font = .systemFont(ofSize: 14, weight: .regular)
        newsDescriptionLabel.textColor = CustomColors.set(to: .majorShadowLightGray)
        newsDescriptionLabel.numberOfLines = 0
        
        contentView.addSubview(newsDescriptionLabel)
        newsDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        newsDescriptionLabel.leadingAnchor.constraint(equalTo: newsImageView.trailingAnchor, constant: 12).isActive = true
        newsDescriptionLabel.topAnchor.constraint(equalTo: newsTitleLabel.bottomAnchor, constant: 12).isActive = true
        newsDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        newsDescriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -12).isActive = true
    }
    
    /// This function configures the updates from the view model to the components of the cell.
    /// - Parameter model: View model which observes the updates for the data.
    public func configure(with model: NewsViewModel) {
        newsTitleLabel.text = model.title
        
        newsDescriptionLabel.text = model.description
        
        if let data = model.imageData {
            newsImageView.image = UIImage(data: data)
        }
        else if let url = model.imageURL {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data else {
                    return
                }
                model.imageData = data
                DispatchQueue.main.async {
                    self?.newsImageView.image = UIImage(data: data)
                }
            }.resume()
        } else {
            newsImageView.image = UIImage(named: "mountains_default")
        }
    }
}
