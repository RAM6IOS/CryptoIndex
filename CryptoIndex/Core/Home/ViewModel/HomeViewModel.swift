//
//  HomeViewModel.swift
//  CryptoIndex
//
//  Created by Bouchedoub Rmazi on 12/5/2022.
//

import Foundation
import Combine
import SwiftUI



class HomeViewModel : ObservableObject {
    
    @Published var statistic : [StatisticModel] = []
    
    @Published var  allconin : [CoinModel] = []
    @Published var portfolioConin : [CoinModel] = []
    @Published var searhBar:String = ""
    @Published var isLoading:Bool = false
    @Published var sortOption: SortOption = .holdings
    
    private let coinDataService = CoinDataService()
    private let markitDataService = MarkitDataService()
    private let protfolioDataService =  PortfolioDataService()
    
    private var coinllblables = Set<AnyCancellable>()
    
    
    enum SortOption {
        case rank ,rankReversed, holdings , holdingsResvrsed , price , priceReversed
    }
    
    
    init(){
        addSubsribers()
        }
        
        func addSubsribers() {
            
            $searhBar
                .combineLatest(coinDataService.$allCoins , $sortOption)
                .map(fiterAndSortCoins)
                .sink{ [weak self] (returnedCoins) in
                    self?.allconin = returnedCoins
                    self?.isLoading = false
                    
                }
                .store(in: &coinllblables)
            
            markitDataService.$markitData
                .combineLatest($portfolioConin)
                .map(mapglobalMarketData)
                .sink{[weak self] (reuturnedStats) in
                      self?.statistic = reuturnedStats
                      
                }
                .store(in: &coinllblables)
            
            
            $allconin
                .combineLatest(protfolioDataService.$savedEntities)
                .map{ (coinModels , protfolioEntities) -> [CoinModel] in
                     coinModels
                        .compactMap{ (coin) -> CoinModel? in
                            guard let entity = protfolioEntities.first(where: {$0.coinID == coin.id }) else {
                                return nil
                            }
                            
                            return coin.updateHoldings(amount: entity.amount)
                    
                }
                        
                }
                .sink{[weak self] (returnedCoins) in
                    guard let self = self else {return }
                    self.portfolioConin = self.sortPortfolioVoinsIfNeeded(coins: returnedCoins)
                }
                .store(in: &coinllblables)
        }
    
    
    
    
    func updatePortfolio(coin: CoinModel , amount: Double){
        protfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    private func fiterAndSortCoins(text:String , coins:[CoinModel] , sort:SortOption) -> [CoinModel] {
        var filteredCoins = filterCoins(text: text, coins: coins)
        let sortedCoins = sortCoins(sort: sort, cons: filteredCoins)
        return sortedCoins
        
    }
    func reloadingData(){
        isLoading = true
        coinDataService.getCoins()
        markitDataService.getData()
    }
    
    private func sortCoins(sort:SortOption , cons: [CoinModel] ) -> [CoinModel]{
        switch sort {
        case .rank , .holdings:
            return cons.sorted(by: {$0.rank < $1.rank })
        case .rankReversed , .holdingsResvrsed :
            return cons.sorted(by: {$0.rank > $1.rank })
        case .price:
            return cons.sorted(by:{ $0.currentPrice > $1.currentPrice})
        case .priceReversed:
                return cons.sorted(by: {$0.currentPrice < $1.currentPrice})
        }
        }
    private func sortPortfolioVoinsIfNeeded(coins:[CoinModel]) ->[CoinModel]{
        switch sortOption {
        case .holdings:
            return coins.sorted(by: {$0.currentHoldingsValue > $1.currentHoldingsValue})
        case .holdingsResvrsed:
            return coins.sorted(by: {$0.currentHoldingsValue < $1.currentHoldingsValue})

            
        default :
            return coins
        }
    }
    
    
    private func mapglobalMarketData(markitDataModel: MarketDataModel? ,portfolioConin: [CoinModel]) -> [StatisticModel]{
        
        var stats: [StatisticModel] = []
        //var coin: [CoinModel] = []
        guard let data = markitDataModel else {

            return stats
        }
        let markeCap = StatisticModel(title: "MarkCap", value: data.marketCap, paercetageChange: data.marketCapChangePercentage24HUsd)
        let volume = StatisticModel(title: "24 h ", value: data.volume)
        let btcDominanace = StatisticModel(title: "BTC Dominanace", value:data.btcDominanace)
        
        
        let potfolioValue =
        portfolioConin
            .map({$0.currentHoldingsValue})
            .reduce(0,+)
        
        let previonusValue =
            portfolioConin
            .map{(coin) -> Double in
                let currentValue = coin.currentHoldingsValue
                let percenChange = coin.priceChangePercentage24H ?? 0  / 100
                let previousValue = currentValue / (1 + percenChange)
                return potfolioValue
            }
            .reduce(0, +)
        
        let percentageChange = ((potfolioValue - previonusValue) / previonusValue) 
        

        let portfolio = StatisticModel(title: "Portfolio Volum", value: previonusValue.asCurrencyWith2Decimals() , paercetageChange: percentageChange)
        
        stats.append(contentsOf: [
            markeCap,
            volume,
            btcDominanace,
            portfolio
        
        
        ])
        
        return stats
    }

    
    private func filterCoins(text: String , coins:[CoinModel])-> [CoinModel]{
        guard !text.isEmpty else {
            return coins
            }
        
        let lowercasedText = text.lowercased()
        
        return coins.filter{ (coins) -> Bool in
            return coins.name.lowercased().contains(lowercasedText) || coins.symbol.lowercased().contains(lowercasedText) ||
            coins.id.lowercased().contains(lowercasedText)
            
        }
        
    }
}
            
//@MainActor
