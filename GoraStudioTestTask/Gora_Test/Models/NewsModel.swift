//
//  NewsModel.swift
//  Gora_Test
//
//  Created by Maksim Khlestkin on 13.03.2022
//

import Foundation

// MARK: - News
struct News: Codable {
    var articles: [Article]?
}

// MARK: - Article
struct Article: Codable {
    let source: Source?
    let author, title, description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

// MARK: - Source
struct Source: Codable {
    let id, name: String?
}
