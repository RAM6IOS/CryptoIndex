//
//  String.swift
//  CryptoIndex
//
//  Created by Bouchedoub Rmazi on 11/6/2022.
//

import Foundation

extension String {
    
    
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
}
