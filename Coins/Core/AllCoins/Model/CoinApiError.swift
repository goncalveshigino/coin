//
//  CoinApiError.swift
//  Coins
//
//  Created by Goncalves Higino on 18/09/23.
//

import Foundation


enum CoinApiError: Error {
    
    case invalidData
    case jsonParsingFailure
    case requestFailed(description: String)
    case invalidStatusCode(statusCode: Int)
    case unknownError(error: Error)
    
    var customDescription: String {
        switch self {
            case .invalidData: return "Invalid data"
            case .jsonParsingFailure: return "Failed to parse JSON"
            case let .requestFailed(description): return "Request failed: \(description)"
            case let .invalidStatusCode(statusCode): return "Invalid status code: \(statusCode)"
            case let .unknownError(error): return "An unkwon error occured \(error.localizedDescription)"
        }
    }
}
