//
//  NetworkService.swift
//  Gora_Test
//
//  Created by Maksim Khlestkin on 13.03.2022
//

import Foundation
import Alamofire

final class NetworkManager {
    
    let apiKey = "YOUR_API_KEY_HERE"
    let url = "https://newsapi.org/v2/top-headlines?country=us&pageSize=20&category="
    
    // MARK: - Make NetworkRequest
    func fetchLastNews(completion: @escaping (_ news: [NewsCategories: News]) -> Void) {
        var result = [NewsCategories: News]()
        let group = DispatchGroup()
        NewsCategories.allCases.forEach { categoryName in
            let request = AF.request(url + categoryName.name + "&apiKey=\(apiKey)")
            group.enter()
            // MARK: - Handle response
            request.responseDecodable(of: News.self) { response in
                switch response.result {
                case .success(let data):
                    if data.articles != nil {
                    result[categoryName] = data
                    }
                case .failure(let error):
                    print(error)
                }
                group.leave()
            }
        }
        // MARK: - Send results to completion block
        group.notify(queue: .main) {
            completion(result)
        }
    }
    
}
