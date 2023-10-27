//
//  CoinsViewModel.swift
//  Coins
//
//  Created by Goncalves Higino on 18/09/23.
//

import Foundation

class CoinsViewModel: ObservableObject {
        
    @Published var coins = [Coin]()
    @Published var error: Error?
    
    private let pageLimit = 20
    private var page = 0
    
    
    let BASE_URL = "https://api.coingecko.com/api/v3/coins/"
    
    
    var urlString: String {
        return "\(BASE_URL)markets?vs_currency=usd&order=market_cap_desc&per_page=\(pageLimit)&page=\(page)&sparkline=false&price_change_percentage=24h&locale=en"
    }
    
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
                    self?.error = error
                }
            }
        }
        
        
    }
    
    func handRefresh() {
        coins.removeAll()
        page = 0
        loadData()
    }
    
    
}


extension CoinsViewModel {
    
    @MainActor
    func fetchCoinsAsync() async throws{
        do {
            page += 1
            guard let url = URL(string: urlString) else { throw CoinApiError.invalidURL }
            let (data,response) = try await URLSession.shared.data(from: url)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw CoinApiError.serverError }
            guard let coins = try? JSONDecoder().decode([Coin].self, from: data) else { throw CoinApiError.invalidData }
            self.coins.append(contentsOf: coins)
        } catch {
            self.error = error
        }
    }
    
    func loadData() {
        Task (priority: .medium) {
           try await fetchCoinsAsync()
        }
    }
}




