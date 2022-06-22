//
//  CoinImageService.swift
//  CryptoIndex
//
//  Created by Bouchedoub Rmazi on 17/5/2022.
//

import Foundation
import SwiftUI
import Combine

class CoinImageService {
    @Published var image : UIImage? = nil
    
    private var imageSubscription : AnyCancellable?
    
    private let coin : CoinModel
    private let filleManager = LocalFileManger.instance
    private let folderName = "coin_image"
    private let imageName : String
    
    init(coin: CoinModel){
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    
    private func getCoinImage(){
        if let savedImage = filleManager.getImage(imageName: imageName, foldername: folderName){
            image = savedImage
    } else {
        downloadCoinImage()
    }
}
    
    
    private func downloadCoinImage(){
        
        guard  let url = URL(string: coin.image) else { return }
        
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedCoins) in
                guard let self = self , let downloadedImage = returnedCoins else { return }
                self.image = returnedCoins
                self.imageSubscription?.cancel()
                self.filleManager.saveImage(image: downloadedImage, imageNmae: self.imageName, folderName: self.folderName)
                
            })
        
        
    }
    
    
}
