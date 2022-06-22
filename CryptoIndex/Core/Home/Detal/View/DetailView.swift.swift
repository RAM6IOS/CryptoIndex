//
//  DetailView.swift.swift
//  CryptoIndex
//
//  Created by Bouchedoub Rmazi on 7/6/2022.
//

import SwiftUI


struct DetailLoadingView:View{
    @Binding  var coin :CoinModel?
    var body:some View {
        ZStack{
            if let coin = coin {
                DetailView(coin: coin)
            }
        }
        
    }
}


struct DetailView: View {
    @StateObject private var  vm: DetailViewModel
    @State private var showFullDescription = false
    private let colmeus:[GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    init(coin:CoinModel){
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
        
    }
    var body: some View {
        
        ScrollView{
            VStack{
           
                ChartView(coin: vm.coin)
                    .padding(.vertical )
            VStack( spacing: 20){
                Text("OverView")
                    .font(.title)
                    .bold()
                    .foregroundColor(Color.theme.accent)
                    .frame( maxWidth: .infinity, alignment:.leading)
                Divider()
                ZStack{
                    if let  coinDescription = vm.coinDescription,!coinDescription.isEmpty{
                        VStack( alignment: .leading){
                        Text(coinDescription)
                                .lineLimit(showFullDescription ? nil : 3)
                            .font(.callout)
                            .foregroundColor(Color.theme.secondarytext)
                            
                            Button{
                                withAnimation(.easeInOut) {
                                    showFullDescription.toggle()
                                }
                                
                            } label: {
                                Text( showFullDescription ? "Less" :"Read Moer..")
                                    .font(.callout)
                                    .fontWeight(.bold)
                                    .padding(.vertical , 4)
                            }
                            .foregroundColor(.blue)
                            
                        }
                    }
                }
                
                LazyVGrid(columns: colmeus ,
                          alignment: .leading,
                          spacing: 30,
                          pinnedViews: [],
                          content: {
                    ForEach(vm.overviewStatistics) { stat in
                        StatisticView(stat: stat)
                        
                    }
                    
                })
                Text("Additional Detail")
                    .font(.title)
                    .bold()
                    .foregroundColor(Color.theme.accent)
                    .frame( maxWidth: .infinity, alignment:.leading)
                
                LazyVGrid(columns: colmeus ,
                          alignment: .leading,
                          spacing: 30,
                          pinnedViews: [],
                          content: {
                    ForEach(vm.additionalStatistics) { stat in
                        StatisticView(stat: stat)
                        
                    }
                    
                })
                
                Divider()
                VStack( alignment: .leading ,spacing: 30){
                    if let websiteStreng = vm.websiteURL,
                       let url = URL(string: websiteStreng){
                        Link("Website" , destination: url)
                            .frame(width: 100, height: 50 )
                            .foregroundColor(Color.white)
                            .background(Color.theme.launc)
                            .cornerRadius(15)
                            
                            
                    }
                        
                    
                    
                    if let redditStreng = vm.redditURL,
                       let url = URL(string: redditStreng){
                        Link("Reddit" , destination:url)
                            .frame(width: 100, height: 50)
                            .foregroundColor(Color.white)
                            .background(Color.theme.launc)
                            .cornerRadius(15)
                            
                    }
                        
                }
                .frame( alignment: .trailing)
                
                  
                }
                
            .padding()
                
                
            }
            }
        .navigationTitle(vm.coin.name)
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing){
                HStack{
                Text(vm.coin.symbol)
                    .font(.headline)
                    .foregroundColor(Color.theme.secondarytext)
                
                CoinImageView(coin: vm.coin)
                    .frame(width: 25, height:25 )
                }
            }
        }
    }
}

struct DetailView_swift_Previews: PreviewProvider {
    static var previews: some View {
        
        DetailView(coin:dev.coin)
        
    }
}
