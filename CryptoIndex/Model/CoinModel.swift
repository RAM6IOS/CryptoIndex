//
//  CoinModel.swift
//  CryptoIndex
//
//  Created by Bouchedoub Rmazi on 10/5/2022.
//

import Foundation
/*
 
https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h
 
 {
   "id": "bitcoin",
   "symbol": "btc",
   "name": "Bitcoin",
   "image": "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
   "current_price": 31521,
   "market_cap": 599664837110,
   "market_cap_rank": 1,
   "fully_diluted_valuation": 661535339234,
   "total_volume": 72619059545,
   "high_24h": 33229,
   "low_24h": 29997,
   "price_change_24h": -1554.3412625616184,
   "price_change_percentage_24h": -4.69946,
   "market_cap_change_24h": -31471798064.61328,
   "market_cap_change_percentage_24h": -4.98653,
   "circulating_supply": 19035962,
   "total_supply": 21000000,
   "max_supply": 21000000,
   "ath": 69045,
   "ath_change_percentage": -54.40595,
   "ath_date": "2021-11-10T14:24:11.849Z",
   "atl": 67.81,
   "atl_change_percentage": 46324.97031,
   "atl_date": "2013-07-06T00:00:00.000Z",
   "roi": null,
   "last_updated": "2022-05-10T10:52:46.387Z",
   "sparkline_in_7d": {
     "price": [
       38548.18801964523,
       38512.541867742686,
       38593.2796384227,
       38600.381689201145,
       38499.49023822234,
       38456.71638807848,
       38582.71635605146,
       38502.65325806351,
       38405.218729098284,
       38265.6279420741,
       38346.618182645456,
       38216.711074462764,
       38137.53874043876,
       37798.806670475926,
       37817.48872035514,
       37669.29571650963,
       37830.12216547759,
       37837.538217933296,
       37758.496107734,
       37957.837710556436,
       37904.84154810051,
       38014.632812547636,
       38064.68258934061,
       38022.88683563204,
       38125.167673011376,
       38428.1559153243,
       38654.076205602,
       38967.7413908414,
       38900.800987870425,
       38988.82549474043,
       39056.21061470828,
       38984.925797991695,
       38867.12079041508,
       38818.33889496153,
       39037.33976692137,
       39208.440956535494,
       38973.60618671578,
       39726.403214335056,
       39874.56204619525,
       39851.90156315212,
       39793.25608747574,
       39750.57955240475,
       39699.02404125388,
       39685.07422234254,
       39664.62139166532,
       39798.306471363365,
       39747.973838730446,
       39784.596625257676,
       39620.560841755134,
       39573.77883902015,
       39627.25868836631,
       39531.07234685239,
       39509.42332989887,
       39570.01981374774,
       39498.088266107035,
       39533.13104403169,
       39064.859747892326,
       38267.13051776845,
       36879.21395023614,
       37055.994426919424,
       36881.42776842956,
       36389.781290852996,
       36289.17938133866,
       36451.02174631506,
       36549.43855330448,
       36328.56806007131,
       36612.229548803036,
       36399.03135676812,
       36302.36663815037,
       36490.733793864,
       36442.512765675834,
       36409.56211166133,
       36513.77013421892,
       36457.57770080964,
       36377.32784705501,
       36322.98742114656,
       36438.39669261041,
       36015.18603760703,
       35875.36844693596,
       36035.122381704336,
       35655.519548178025,
       36177.512842969176,
       36059.8406249991,
       36242.14270580665,
       35983.32230536464,
       36056.77732442302,
       36059.53318624313,
       36137.758675650184,
       36011.70421390417,
       36059.424839527106,
       36075.60763739326,
       36056.19944594724,
       36063.55917478897,
       36008.856589628034,
       35894.4740732224,
       35844.14275957303,
       35907.57906925114,
       35860.76512981547,
       35985.7497912425,
       36038.853185301785,
       36038.8684628128,
       36127.717399182184,
       36084.99574395998,
       36055.633846645964,
       35945.34604403467,
       35999.5027132208,
       36008.72675650056,
       35995.76307476394,
       35952.38637376527,
       35961.13150276985,
       35937.841716244795,
       35863.22620788247,
       35355.359251151895,
       35122.848833804754,
       35557.835777517306,
       35187.31532210283,
       35017.030607486835,
       34604.46343561648,
       34487.48515107902,
       34538.803396538366,
       34466.05547955045,
       34838.52990556284,
       34707.885606080956,
       34715.35192715631,
       34618.02560052422,
       34750.55778026926,
       34834.340082901,
       34708.27426470359,
       34503.65806427588,
       34458.85058395454,
       34457.14951423605,
       34446.54395187685,
       34101.13283514223,
       34534.93274078071,
       34629.13699584336,
       34333.445077574615,
       34501.64702889456,
       34337.667495464615,
       34070.31219757961,
       34180.867776928135,
       34086.147645359415,
       33370.7560251016,
       33670.32990632951,
       33706.22263680905,
       33553.580569142614,
       33619.15623161581,
       33605.71037176825,
       33668.01930683948,
       33492.39920819844,
       33038.196447853756,
       33111.832129630995,
       32984.19722666177,
       33125.95789505212,
       32589.246154582583,
       32308.86170579508,
       31733.72132440073,
       31506.391770142705,
       30771.425301428466,
       30709.404234474125,
       31182.424996183945,
       31224.124919952916,
       31206.317554647587,
       30269.586956629482,
       30385.259966645815,
       30988.992467345437,
       31069.33278130602,
       30712.554517429202,
       31150.637096230104
     ]
   },
   "price_change_percentage_24h_in_currency": -4.6994559520654
 }


*/


struct CoinModel: Identifiable , Codable{
    
    let id, symbol, name: String
    let image: String
    let currentPrice: Double
    let marketCap, marketCapRank, fullyDilutedValuation: Double?
    let totalVolume, high24H, low24H: Double?
    let priceChange24H: Double?
    let priceChangePercentage24H: Double?
    let marketCapChange24H: Double?
    let marketCapChangePercentage24H: Double?
    let circulatingSupply, totalSupply, maxSupply, ath: Double?
    let athChangePercentage: Double?
    let athDate: String?
    let atl, atlChangePercentage: Double?
    let atlDate: String?
    let lastUpdated: String?
    let sparklineIn7D: SparklineIn7D?
    let priceChangePercentage24HInCurrency: Double?
    let currentHoldings: Double?
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case marketCapChange24H = "market_cap_change_24h"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case ath
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case lastUpdated = "last_updated"
        case sparklineIn7D = "sparkline_in_7d"
        case priceChangePercentage24HInCurrency = "price_change_percentage_24h_in_currency"
        case currentHoldings
    }
    
    func updateHoldings(amount: Double) -> CoinModel {
        return CoinModel(id: id, symbol: symbol, name: name, image: image, currentPrice: currentPrice, marketCap: marketCap, marketCapRank: marketCapRank, fullyDilutedValuation: fullyDilutedValuation, totalVolume: totalVolume, high24H: high24H, low24H: low24H, priceChange24H: priceChange24H, priceChangePercentage24H: priceChangePercentage24H, marketCapChange24H: marketCapChange24H, marketCapChangePercentage24H: marketCapChangePercentage24H, circulatingSupply: circulatingSupply, totalSupply: totalSupply, maxSupply: maxSupply, ath: ath, athChangePercentage: athChangePercentage, athDate: athDate, atl: atl, atlChangePercentage: atlChangePercentage, atlDate: atlDate, lastUpdated: lastUpdated, sparklineIn7D: sparklineIn7D, priceChangePercentage24HInCurrency: priceChangePercentage24HInCurrency, currentHoldings: amount)
        
        
    }
    var currentHoldingsValue: Double {
        return (currentHoldings ?? 0) * currentPrice
    }
    
    var rank: Int {
        return Int(marketCapRank ?? 0)
    }
}

// MARK: - SparklineIn7D
struct SparklineIn7D: Codable {
    let price: [Double]?
}

class Coin {
    
    
}
