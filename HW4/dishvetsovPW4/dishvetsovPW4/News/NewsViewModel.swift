//
//  NewsViewModel.swift
//  dishvetsovPW4
//
//  Created by Danil Shvetsov on 04.12.2022.
//

import UIKit

// The final class for the news view model.
final class NewsViewModel: Codable {
    
    // The title of the news model.
    let title: String?
    
    // The description of the news model.
    let description: String?
    
    // The url for the news model.
    let imageURL: URL?
    
    // The url for the news model in a string representation.
    var urlToImage: String? = nil
    
    // The data for the news model.
    var imageData: Data? = nil
    
    // MARK: - Init.
    init(title: String?, description: String?, imageURL: URL?) {
        self.title = title
        self.description = description
        self.imageURL = imageURL
    }
}
