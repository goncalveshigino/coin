//
//  CoinsViewModel.swift
//  Coins
//
//  Created by Goncalves Higino on 18/09/23.
//

import Foundation

class CoinsViewModel: ObservableObject {
    
//    @Published var coin = ""
//    @Published var price = ""

    
    @Published var coins = [Coin]()
    @Published var errorMessage: String?
    
    private let service = CoinDataService()
    
    init() {
        fetchCoins()
    }
    
    func fetchCoins() {

        service.fetchCoinsWithResul { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let coins):
                    self?.coins = coins
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
        
        
    }
    
    
}


//    func fetchPrice(coin: String) {
//        service.fetchPrice(coin: coin) { priceFormService in
//            DispatchQueue.main.async {
//                self.price = "$\(priceFormService)"
//                self.coin = coin
//            }
//        }
//    }
    
    //        service.fetchCoins { coins, error in
    //            DispatchQueue.main.async {
    //                if let error = error {
    //                    self.errorMessage = error.localizedDescription
    //                    return
    //                }
    //                self.coins = coins ?? []
    //            }
    //        }
