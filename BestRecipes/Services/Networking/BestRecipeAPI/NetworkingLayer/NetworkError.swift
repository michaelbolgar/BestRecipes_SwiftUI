//
//  NetworkError.swift
//  BestRecipes
//
//  Created by Alexander Abanshin on 12.08.2025.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidRequest
    case invalidResponse(statusCode: Int)
    case decodingFailed(Error)
    case connectionFailed(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidRequest:
            return "Invalid request URL or parameters"
        case .invalidResponse(let statusCode):
            return "Server returned unexpected status code: \(statusCode)"
        case .decodingFailed(let error):
            return "Failed to decode response: \(error.localizedDescription)"
        case .connectionFailed(let error):
            return "Network connection failed: \(error.localizedDescription)"
        }
    }
}
