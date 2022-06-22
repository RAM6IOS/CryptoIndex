//
//  SearchBarView.swift
//  CryptoIndex
//
//  Created by Bouchedoub Rmazi on 21/5/2022.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var  searchText: String
    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass")
                .foregroundColor(
                    searchText.isEmpty ?
                    Color.theme.secondarytext : Color.theme.accent
                    
                    )
            TextField("Search by name or symbole" , text: $searchText )
                .foregroundColor(Color.theme.accent)
                .disableAutocorrection(true)
            
                .overlay(
                    Button{
                        searchText = ""
                        
                    } label: {
                        
                    
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x:10)
                        .foregroundColor(Color.theme.accent)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        
                    }
                    ,alignment: .trailing
                    
                )
        
            
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.background)
                .shadow(color: Color.theme.accent.opacity(0.15), radius: 10, x: 0, y: 0)
        )
        .padding()
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            SearchBarView(searchText: .constant(""))
                .previewLayout(.sizeThatFits)
                .colorScheme(.dark)
            SearchBarView(searchText: .constant(""))
                    .previewLayout(.sizeThatFits)
                    .colorScheme(.light)
        }
    }
}
