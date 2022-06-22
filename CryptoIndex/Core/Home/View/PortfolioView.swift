//
//  PortfolioView.swift
//  CryptoIndex
//
//  Created by Bouchedoub Rmazi on 27/5/2022.
//

import SwiftUI

struct PortfolioView: View {
    @Environment(\.dismiss) var dismis
    @EnvironmentObject private var vm : HomeViewModel
    
    @State private var selectedCoin: CoinModel? = nil
    @State private var quantityText: String = ""
    @State private var showChecKmark :Bool = false

    //let coin :  CoinModel
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(alignment: .leading, spacing: 0){
                    SearchBarView(searchText:$vm.searhBar )
                    
                    
                    coinLogeList
                    
                    
                    if selectedCoin != nil {
                        VStack{
                            HStack{
                                Text("Current price of \(selectedCoin?.symbol.uppercased() ?? " "):")
                                Spacer()
                                Text("\(selectedCoin?.currentPrice.asCurrencyWith6Decimals() ?? " ")")
                            }
                            Divider()
                            HStack{
                                Text("Amount in your portfolio:")
                                Spacer()
                                TextField("Ex:1.4", text: $quantityText)
                                    .multilineTextAlignment(.trailing)
                                    .keyboardType(.decimalPad)
                                
                                
                            }
                            Divider()
                            HStack{
                                Text("Current Velue:")
                                Spacer()
                                Text(getCirrentValue().asCurrencyWith2Decimals())
                            }
                        }
                        .padding(.horizontal , 10)
                    }
                    
                    
                    
                    
                }
               
                
            }
            .navigationTitle("Edit Profel")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading){
                    Button{
                        dismis()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.headline)
                       
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    HStack{
                    Image(systemName: "chekmark")
                        .opacity(showChecKmark ? 1.0 : 0.0)
                    Button{
                        saveButtonPressed()
                    } label: {
                        Text("Save".uppercased())
                    }
                    .opacity(
                        (selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText)) ? 1.0 : 0.0
                    )
                    }
                    .font(.headline)
                    
                }
                
            
            })
            
           
            
            
        }
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
            .environmentObject(dev.homeVM)
    }
}




extension PortfolioView {
    
    private var coinLogeList : some View {
        
        
        ScrollView(.horizontal , showsIndicators: false ,content: {
           
                
                HStack( spacing: 10){
                    ForEach(vm.searhBar.isEmpty ? vm.portfolioConin : vm.allconin) { coni in
                       CoinLogoView(coin: coni)
                            .frame(width: 75)
                            .padding(4)
                            .onTapGesture{
                                withAnimation(.easeIn) {
                                    selectedCoin = coni
                                }
                            }
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(selectedCoin?.id == coni.id ? Color.theme.green : Color.clear , lineWidth: 1)
                            
                            )
                    }
                    
                }
                
            
            
        })
        
    }
    
    func updateSelectdCoin(coin: CoinModel) {
        selectedCoin = coin
        
        if let portfolioCoin = vm.portfolioConin.first(where: {$0.id == coin.id}) ,
           let amount = portfolioCoin.currentHoldings {
            quantityText = "\(amount)"
        } else {
            quantityText = ""
        }
        
        
    }
    
    private func getCirrentValue() -> Double{
        if let quantity = Double(quantityText) {
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
        
    }
    
    private func saveButtonPressed(){
        guard
        let coin = selectedCoin,
        let amount = Double(quantityText)
        else  { return }
        
        vm.updatePortfolio(coin: coin, amount: amount)
        
        withAnimation(.easeIn){
            showChecKmark = true
            remveSelectedCoin()
        }
        UIApplication.shared.endEditing()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(.easeIn){
                showChecKmark = false
            }
        }
    }
    
    private func remveSelectedCoin(){
        selectedCoin = nil
        vm.searhBar = ""
    }
}
