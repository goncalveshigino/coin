//
//  CoinsViewModel.swift
//  Coins
//
//  Created by Goncalves Higino on 18/09/23.
//

import Foundation

class CoinsViewModel: ObservableObject {
        
    @Published var coins = [Coin]()
    @Published var errorMessage: String?
    
    
    
    private let service = CoinDataService()
    
    init()  {
        loadData()
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


extension CoinsViewModel {
    
    @MainActor
    func fetchCoinsAsync() async throws{
        guard let url = URL(string: service.urlString) else {
            print("DEBUG: Invalid URL")
            return
        }
        
        let (data,response) = try await URLSession.shared.data(from: url)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { return }
        guard let coins = try? JSONDecoder().decode([Coin].self, from: data) else { return }
        self.coins = coins
    }
    
    func loadData() {
        Task (priority: .medium) {
           try await fetchCoinsAsync()
        }
    }
}




