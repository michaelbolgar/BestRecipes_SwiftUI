//
//  NetworkRouter.swift
//  BestRecipes
//
//  Created by Alexander Abanshin on 12.08.2025.
//

import Foundation

enum NetworkRouter {
    static func buildURLRequest(_ endpoint: Endpoint) -> URLRequest? {
        URLComponents(string: endpoint.baseURL)
            .flatMap {
                var components = $0
                components.path = endpoint.path
                components.queryItems = endpoint.queryItems
                return components.url
            }
            .map {
                var request = URLRequest(url: $0)
                request.addValue(API.apiKey, forHTTPHeaderField: API.header)
                request.httpMethod = endpoint.httpMethod.rawValue
                return request
            }
    }
    
}

