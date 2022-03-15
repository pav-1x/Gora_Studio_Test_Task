//
//  Constants.swift
//  Gora_Test
//
//  Created by Maksim Khlestkin on 13.03.2022
//

import Foundation

enum NewsCategories: Int, CaseIterable {
    case business, entertainment, general, health, science, sports, technology
    var name: String {
        switch self {
        case .business:
            return "business"
        case .entertainment:
            return "entertainment"
        case .general:
            return "general"
        case .health:
            return "health"
        case .science:
            return "science"
        case .sports:
            return "sports"
        case .technology:
            return "technology"
        }
    }
}
