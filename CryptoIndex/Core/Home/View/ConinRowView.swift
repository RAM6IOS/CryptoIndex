//
//  ConinRowView.swift
//  CryptoIndex
//
//  Created by Bouchedoub Rmazi on 11/5/2022.
//

import SwiftUI

struct ConinRowView: View {
    let coin :  CoinModel
    let showHoldingColumn: Bool
    var body: some View {
        HStack( spacing: 0){
             
            leftColme
            
            Spacer()
            if showHoldingColumn {
                
                centerColme
                
            }
            Spacer()
            
            rightColume
            
        }
        .background(
            Color.theme.background.opacity(0.001)
        )
    }
}

struct ConinRowView_Previews: PreviewProvider {
    static var previews: some View {
        ConinRowView(coin:  dev.coin, showHoldingColumn: true)
    }
}







extension ConinRowView {
    
    private var leftColme : some View {
        
        HStack( spacing: 0){
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundColor(Color.theme.secondarytext)
                .frame(minWidth: 30)
            CoinImageView(coin: coin)
                .frame(width: 30, height: 30)
            /*
            AsyncImage(url: URL(string: coin.image)){ phase in
                if let image = phase.image {
                    image
                    .resizable()
                  .scaledToFit()
            } else if phase.error != nil {
                Text("There was an error loading the image.")
            } else {
                ProgressView()
            }
            
            }
            .frame(width: 30, height: 30)
            */
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading,6)
                .foregroundColor(Color.theme.accent)
            
        }
        
    }
    
    private var centerColme : some View {
        
        VStack(alignment: .trailing){
            Text(coin.currentHoldingsValue.asCurrencyWith2Decimals())
                .bold()
         Text((coin.currentHoldings ?? 0).asNumberString())
        }
        .foregroundColor(Color.theme.accent)
        
    }
    
    private var rightColume : some View {
        
        HStack( spacing: 0){
        Image(systemName:(coin.priceChangePercentage24H ?? 0) >= 0 ? "arrow.up" : "arrow.down")
            .font(.system(size: 25))
            .frame( maxHeight: 40)
            .foregroundColor((coin.priceChangePercentage24H ?? 0) >= 0 ?  Color.theme.green : Color.theme.red)
    VStack(alignment: .trailing){
        Text(coin.currentPrice.asPercentString())
            .bold()
            .foregroundColor(Color.theme.accent)
        Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
            .foregroundColor((coin.priceChangePercentage24H ?? 0) >= 0 ? Color.theme.green : Color.theme.red)
    }
        
    }
    }
    
    
}
