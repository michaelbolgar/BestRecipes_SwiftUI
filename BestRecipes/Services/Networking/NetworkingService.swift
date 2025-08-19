//
//  NetworkingService 2.swift
//  BestRecipes
//
//  Created by KOZLOVA Anastasia on 15.08.2025.
//

import Foundation

final class NetworkingService {
    func fetch<T: Decodable>(from endpoint: Endpoint) async throws -> T {
        guard let urlRequest = NetworkRouter.buildURLRequest(endpoint) else {
            throw NetworkError.invalidRequest
        }
        
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse(statusCode: 0)
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.invalidResponse(statusCode: httpResponse.statusCode)
            }
      
            if let resultData = data as? T {
                return resultData
            }
      
            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                throw NetworkError.decodingFailed(error)
            }
            
    }
}
