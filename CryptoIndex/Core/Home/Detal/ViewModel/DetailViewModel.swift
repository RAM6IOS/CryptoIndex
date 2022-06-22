//
//  DetailViewModel.swift
//  CryptoIndex
//
//  Created by Bouchedoub Rmazi on 8/6/2022.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject{
    
    @Published var    overviewStatistics : [StatisticModel] = []
    @Published var  additionalStatistics : [StatisticModel] = []
    @Published var  coinDescription: String? = nil
    @Published var   websiteURL : String? = nil
    @Published var   redditURL:String? = nil
    
    
    
    
    private var coinDetailService : CoinDetailService
    @Published  var coin :CoinModel
    private var coinllblables = Set<AnyCancellable>()
    
    init(coin:CoinModel){
        self.coin = coin
        self.coinDetailService = CoinDetailService(coin: coin)
        self.addSubsribers()
        
    }

    
    private func addSubsribers(){
        coinDetailService.$coinsDetail
            .combineLatest($coin)
            .map({ (coinDetailModel, coinModel) -> ( overview:[StatisticModel] , additional:[StatisticModel]) in
                //overView
                //
                let price = coinModel.currentPrice.asCurrencyWith6Decimals()
                let pricePerrcentChange = coinModel.priceChangePercentage24H
                let priceStat = StatisticModel(title: "Cirnent Price", value: price, paercetageChange: pricePerrcentChange)
                
                let marketCap = "$" + (coinModel.marketCap?.formattedWithAbbreviations() ?? " ")
                let marketCapPerrcentChange = coinModel.marketCapChangePercentage24H
                let marketStat = StatisticModel(title: "Market Capitalization", value: marketCap, paercetageChange: marketCapPerrcentChange)
                
                let rank = "\(coinModel.rank)"
                let rankStat = StatisticModel(title: " Rank", value: rank)
                
                let volume = "$" + (coinModel.totalVolume?.formattedWithAbbreviations() ??  " ")
                let volimeStat = StatisticModel(title: "Volume", value: volume)
                
                let overviewArry: [StatisticModel] = [
                    priceStat, marketStat, rankStat, volimeStat
                ]
                
                //additional
                //
                
                let high = coinModel.high24H?.asCurrencyWith6Decimals() ??  "n/a"
                let highStat = StatisticModel(title: "24h High", value: high)
                
                let low = coinModel.low24H?.asCurrencyWith6Decimals() ?? "n/a"
                let loeStat = StatisticModel(title: "24h Low", value: low)
                
                let pricChange = coinModel.priceChangePercentage24H?.asCurrencyWith6Decimals() ?? "n/a"
                let pricePerrcentChange2 = coinModel.priceChangePercentage24H
                let  pricChangeStat = StatisticModel(title: "24h Change Pric", value: pricChange, paercetageChange: pricePerrcentChange2)
                
                
                let marketCapChange = "$" + (coinModel.marketCapChange24H?.asCurrencyWith6Decimals() ?? "n/a")
                let marketCapPerrcentChange2 =  coinModel.marketCapChangePercentage24H
                let  marketCapChangeStat = StatisticModel(title: "24H Mark Cap Change", value: marketCapChange, paercetageChange: marketCapPerrcentChange)
                
                let blockTime = coinDetailModel?.blockTimeInMinutes ?? 0
                let blockTimeString = blockTime == 0 ?  "\(blockTime)" : "n/a"
                let blockStat = StatisticModel(title: "Block Time", value: blockTimeString )
                
                let hashing = coinDetailModel?.hashingAlgorithm ?? "n/a"
                let hashingStat = StatisticModel(title: "Hashing Algorithm", value: hashing)
                
                let additionalArray: [StatisticModel]=[
                   highStat , loeStat , pricChangeStat , marketCapChangeStat , blockStat , hashingStat
                ]
                
                return (overviewArry , additionalArray)
            })
            .sink{[weak self] (returnedArrays) in
                self?.overviewStatistics = returnedArrays.overview
                self?.additionalStatistics = returnedArrays.additional
                
            }
            .store(in: &coinllblables)
        coinDetailService.$coinsDetail
            .sink{[weak self] (returndCoinDetails) in
                self?.coinDescription = returndCoinDetails?.readableDescription
                self?.websiteURL = returndCoinDetails?.links?.homepage?.first
                self?.redditURL = returndCoinDetails?.links?.subredditURL
                
            }
            .store(in: &coinllblables)
        
        
    }
    
}
