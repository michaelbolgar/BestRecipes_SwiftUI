//
//  API.swift
//  BestRecipes
//
//  Created by Alexander Abanshin on 12.08.2025.
//

import Foundation

enum API {
    static let apiKey = ApiKeys.third
    static let header = "x-api-key"
}

enum HTTPMethod: String {
    case get = "GET"
}

enum ApiKeys: String {
    case firstKey = "dbe02e6c827948cab1164a95cab41203"
    case secondKey = "97534030321f4b98b1a71a171f2a5d77"
    case third = "5ae93d38d7cf4f94912465f822fa82eb"
}
