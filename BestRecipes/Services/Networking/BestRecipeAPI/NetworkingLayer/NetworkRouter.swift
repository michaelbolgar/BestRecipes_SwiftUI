//
//  NetworkRouter.swift
//  BestRecipes
//
//  Created by Alexander Abanshin on 12.08.2025.
//

import Foundation

enum NetworkRouter {
    static func buildURLRequest(_ endpoint: Endpoint) -> URLRequest? {
      var baseURL = endpoint.baseURL
        print(baseURL)
      if case .getIngredientImage = endpoint {
        baseURL = endpoint.baseImgURL
      }
      return URLComponents(string: baseURL)
            .flatMap {
                var components = $0
                components.path = endpoint.path
                components.queryItems = endpoint.queryItems
                print(components.url)
                return components.url
            }
            .map {
                var request = URLRequest(url: $0)
                request.addValue(API.apiKey.rawValue, forHTTPHeaderField: API.header)
                request.httpMethod = endpoint.httpMethod.rawValue
                print(request)
                return request
            }
    }
    
}

