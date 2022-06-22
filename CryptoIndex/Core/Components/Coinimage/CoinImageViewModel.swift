//
//  CoinImageViewModel.swift
//  CryptoIndex
//
//  Created by Bouchedoub Rmazi on 17/5/2022.
//

import Foundation
import SwiftUI
import Combine



class CoinImageViewModel : ObservableObject {
    
    @Published var image : UIImage? = nil
    @Published  var isLoading : Bool = false
    
    private let coin : CoinModel
    private let dadaService : CoinImageService
    private var coinllblables = Set<AnyCancellable>()
    
    init(coin: CoinModel){
        self.coin = coin
        self.dadaService = CoinImageService(coin: coin )
        self.addSubscriberse()
        self.isLoading = true
    }
    
    
    private func addSubscriberse() {
        
        dadaService.$image
            .sink{[weak self] (_) in
                self?.isLoading = false
                
            } receiveValue: { [weak self] (returnedImage) in
                self?.image = returnedImage
            }
            .store(in: &coinllblables)
        
    }
    
}

