//
//  CoinModelDetail.swift
//  CryptoIndex
//
//  Created by Bouchedoub Rmazi on 8/6/2022.


import Foundation
//import SwiftUI

// MARK: - Welcome
struct CoinModelDetail : Identifiable, Codable {
    let id, symbol, name: String?
    let blockTimeInMinutes: Int?
    let hashingAlgorithm: String?
    let description: Description?
    let links: Links?
    
    enum CodingKeys: String, CodingKey {
        case id, symbol,name , description , links
        case blockTimeInMinutes = "block_time_in_minutes"
        case hashingAlgorithm = "hashing_algorithm"
        
    }
    var readableDescription: String?{
        return description?.en?.removingHTMLOccurances
    }
}


// MARK: - Links
struct Links: Codable {
    let homepage: [String]?
    let subredditURL: String?
    
    enum CodingKeys: String, CodingKey {
        case homepage
        case subredditURL = "subreddit_url"
    }
    
}

// MARK: - Description
struct Description : Codable{
    let en: String?
}
