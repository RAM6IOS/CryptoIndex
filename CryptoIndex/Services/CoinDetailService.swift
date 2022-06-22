//
//  CoinDetailService.swift
//  CryptoIndex
//
//  Created by Bouchedoub Rmazi on 8/6/2022.
//




import Foundation
import Combine


class CoinDetailService  {
   
    @Published  var  coinsDetail: CoinModelDetail? = nil
    var coinDetailSubscription : AnyCancellable?
    let coin: CoinModel
    
    init(coin:CoinModel){
        self.coin = coin
        getCoinsDetail()
    }
    
    
    func getCoinsDetail(){
        
        guard  let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false") else { return }
        
        
        coinDetailSubscription = NetworkingManager.download(url: url)
            .decode(type: CoinModelDetail.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedCoinsDetiel) in
                self?.coinsDetail = returnedCoinsDetiel
                self?.coinDetailSubscription?.cancel()
                
            })
            

        
    }
        
}

