//
//  CoinDataService.swift
//  CryptoIndex
//
//  Created by Bouchedoub Rmazi on 15/5/2022.
//

import Foundation
import Combine


class CoinDataService : ObservableObject {
   
    @Published  var  allCoins: [CoinModel] = []
    var coinSubscription : AnyCancellable?
    
    init(){
        getCoins()
    }
    
    //https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=true&price_change_percentage=24h

    
    func getCoins(){
        
        guard  let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=true&price_change_percentage=24h") else { return }
        
        
        coinSubscription = NetworkingManager.download(url: url)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
                self?.coinSubscription?.cancel()
                
            })
            

        
    }
        
}



@MainActor
class CountriesModel: ObservableObject {
    @Published var countries : [CoinModel] = []
    
    func reload() async {
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
        let urlSession = URLSession.shared

        do {
            let (data, _) = try await urlSession.data(from: url)
            let decodedResponse = try JSONDecoder().decode([CoinModel].self, from: data)
            self.countries = decodedResponse
        }
        catch {
            // Error handling in case the data couldn't be loaded
            // For now, only display the error on the console
            debugPrint("Error loading \(url): \(String(describing: error))")
        }
    }
}
