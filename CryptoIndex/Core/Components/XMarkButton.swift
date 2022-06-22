//
//  XMarkButton.swift
//  CryptoIndex
//
//  Created by Bouchedoub Rmazi on 28/5/2022.
//

import SwiftUI

struct XMarkButton: View {
    @Environment(\.dismiss) var dismis
    var body: some View {
        
        Button{
            dismis()
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
           
        }
    }
}

struct XMarkButton_Previews: PreviewProvider {
    static var previews: some View {
        XMarkButton()
            .previewLayout(.sizeThatFits)
    }
}
