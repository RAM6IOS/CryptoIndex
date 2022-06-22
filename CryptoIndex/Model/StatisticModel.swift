//
//  StatisticModel.swift
//  CryptoIndex
//
//  Created by Bouchedoub Rmazi on 24/5/2022.
//

import Foundation



struct StatisticModel: Identifiable {
    let id = UUID().uuidString
    let title: String
    let value: String
    let percentageChange: Double?
    
    init(title:String ,value:String , paercetageChange:Double? = nil){
        self.title = title
        self.value = value
        self.percentageChange = paercetageChange
        
    }
   
}



