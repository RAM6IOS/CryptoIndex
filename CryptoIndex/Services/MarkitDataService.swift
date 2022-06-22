//
//  MarkitDataService.swift
//  CryptoIndex
//
//  Created by Bouchedoub Rmazi on 26/5/2022.
//

import Foundation
import Combine


class MarkitDataService {
   
    @Published  var  markitData: MarketDataModel? 
    var marKetdataSubscription : AnyCancellable?
    
    init(){
        getData()
    }
    
    
    func getData(){
        
        guard  let url = URL(string: "https://api.coingecko.com/api/v3/global"
) else { return }
        
        
        marKetdataSubscription = NetworkingManager.download(url: url)
            .decode(type:GlobalData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedWelcome) in
                self?.markitData = returnedWelcome.data
                self?.marKetdataSubscription?.cancel()
                
            })
            

        
    }
        
}

