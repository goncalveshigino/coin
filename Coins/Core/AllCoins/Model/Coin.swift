//
//  Coin.swift
//  Coins
//
//  Created by Goncalves Higino on 18/09/23.
//

import Foundation

struct Coin: Codable, Identifiable {
    
    let id: String
    let symbol: String
    let name: String
    let image: String
    let currentPrice: Double
    let marketCapRank: Int
    
    private enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case marketCapRank = "market_cap_rank"
    }
    
}
