//
//  UIApplication.swift
//  CryptoIndex
//
//  Created by Bouchedoub Rmazi on 21/5/2022.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
