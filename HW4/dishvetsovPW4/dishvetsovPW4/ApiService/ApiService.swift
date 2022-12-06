//
//  ApiService.swift
//  dishvetsovPW4
//
//  Created by Danil Shvetsov on 04.12.2022.
//

import UIKit

// Constants which contain main url parts of work with the News API.
struct Constants {
    static let baseURL = "https://newsapi.org/v2"
    static let API_KEY = "c59a71cffc4840bf87172651ef33ec71"
    static let countryKEY = "ru"
}

// Enum describing the custom error of data loading from API.
enum APIError: Error {
    case failedToGetData
}

// Class of work with API.
final class ApiService {
    
    // Static field - instance of API for the use in external classes.
    static let shared = ApiService()
    
    /// This function executes the load of top stories from the request to API service and then forms the answer from json model to news top stories.
    /// - Parameter completion: The method which is a closure for execution of slow network request.
    func getTopStories(completion: @escaping (Result<[NewsViewModel], Error>) -> Void) {
        
        // Forming the url string for request to the API.
        guard let url = URL(
            string: "\(Constants.baseURL)/top-headlines?country=\(Constants.countryKEY)&apiKey=\(Constants.API_KEY)"
        ) else { return }
        
        // Forming and start session for execution of url process and decoding its' data from json to model.
        URLSession.shared.dataTask(with: url) { data, _, error in
            
            guard let data = data, error == nil else { return }
        
            do {
                let results = try JSONDecoder().decode(NewsTopStoriesResponse.self, from: data)
                
                completion(.success(results.articles))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }.resume()
    }
}
