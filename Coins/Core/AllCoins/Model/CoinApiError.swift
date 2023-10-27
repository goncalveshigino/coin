//
//  CoinApiError.swift
//  Coins
//
//  Created by Goncalves Higino on 18/09/23.
//

import Foundation


enum CoinApiError: Error, LocalizedError {
    
    case invalidURL
    case serverError
    case invalidData
    case jsonParsingFailure
    case requestFailed(description: String)
    case invalidStatusCode(statusCode: Int)
    case unknown(Error)
    
    var customDescription: String {
        switch self {
            case .invalidData: return "Invalid data"
            case .jsonParsingFailure: return "Failed to parse JSON"
            case let .requestFailed(description): return "Request failed: \(description)"
            case let .invalidStatusCode(statusCode): return "Invalid status code: \(statusCode)"
            case let .unknown(error): return error.localizedDescription
        case .invalidURL:
            return ""
        case .serverError:
            return "There was an error the server. Please try again later"
        }
    }
}
