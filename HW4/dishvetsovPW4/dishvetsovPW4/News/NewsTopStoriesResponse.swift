//
//  NewsTopStoriesResponse.swift
//  dishvetsovPW4
//
//  Created by Danil Shvetsov on 04.12.2022.
//

import UIKit

// The structure for response from API.
struct NewsTopStoriesResponse: Codable {
    
    // The field where the list of articles is parsed.
    let articles: [NewsViewModel]
    
}
