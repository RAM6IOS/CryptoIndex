//
//  HomeView.swift
//  CryptoIndex
//
//  Created by Bouchedoub Rmazi on 8/5/2022.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var vm : HomeViewModel
    @StateObject var countriesModel = CountriesModel()
    @State  private var showPorfolio : Bool = false
    @State private var showPortfolioView : Bool = false
    @State private var showSettingsView : Bool = false
    @State private var selectedCoin:CoinModel? = nil
    @State private var showDetailView:Bool = false
    
   // @StateObject var countriesModel2 = CountriesModel()
    var body: some View {
        ZStack{
            Color.theme.background
                .ignoresSafeArea()
                .sheet(isPresented: $showPortfolioView, content: {
                    PortfolioView()
                    
                })
                .task {
                           await countriesModel.reload()
                    print(countriesModel.countries)
                       }
        VStack{
            
            homeHeader
            HomeStatsView( showPorfolio: $showPorfolio)
            SearchBarView(searchText:$vm.searhBar )
            
            columnlest
            
            if !showPorfolio {
                
                
            allConinsList
            .transition(.move(edge: .leading))
            }
            if showPorfolio {
                
                portfolioConinsList
                    .transition(.move(edge: .trailing))
                
            }
            
            Spacer(minLength: 0)
            
            
        }.sheet(isPresented: $showSettingsView, content: {
            SettingsView()
            
        })
         
            
        
        
            
        }
        .background(
            NavigationLink( destination: DetailLoadingView(coin: $selectedCoin), isActive: $showDetailView, label: {
                EmptyView()
            })
        )
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
        HomeView()
                .navigationBarHidden(true)
        }
        .environmentObject(dev.homeVM)
    }
}


extension HomeView {
    private var homeHeader : some View {
        
        HStack{
            CircleButton(iconName:showPorfolio ? "plus" : "info")
                .animation(.none, value: showPorfolio)
                .background(
                    CircleButtonAnimationView(amiate: $showPorfolio)
                )
                .onTapGesture {
                    if showPorfolio {
                        showPortfolioView.toggle()
                    } else {
                        showSettingsView.toggle()
                    }
                }
            Spacer()
            
            Text( showPorfolio ? "Portfolio" : "Live Pricis")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)
                .animation(.none, value: showPorfolio)
            Spacer()
            CircleButton(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPorfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()){
                        showPorfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
        
    }
    
    private var allConinsList : some View {
        
        List{
            
            ForEach(vm.allconin) { coni in
                ConinRowView(coin: coni, showHoldingColumn: false)
                    .listRowInsets(.init(top:10 , leading: 0 , bottom: 10 , trailing: 10))
                    .onTapGesture {
                        segue(coin: coni)
                    }
                
            }
            
        }
        .listStyle(PlainListStyle())
        
    }
    private func segue(coin:CoinModel){
        selectedCoin = coin
        showDetailView.toggle()
        
    }
    
    private var portfolioConinsList : some View {
        
        
        List{
            
            ForEach(vm.portfolioConin ) { coni in
                
                ConinRowView(coin: coni, showHoldingColumn: true)
                    .listRowInsets(.init(top:10 , leading: 0 , bottom: 10 , trailing: 10))
                    .onTapGesture {
                        segue(coin: coni)
                    }
                
            }
            
        }
        .listStyle(PlainListStyle())
        
        
    }
    
    private var columnlest : some View {
        
        HStack{
            HStack( spacing: 4){
                Text("Coin")
             Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .rank || vm.sortOption == .rankReversed) ? 1.0 : 0.0 )
                    .rotationEffect(Angle(degrees: vm.sortOption == .rank ? 0 : 180))
            }
            .onTapGesture {
                withAnimation(.default) {
                    vm.sortOption = vm.sortOption == .rank ? .rankReversed : .rank
                }
            }
            
            
            
              Spacer()
            
            if showPorfolio {
                HStack( spacing: 4){
                Text("Holdings")
                 Image(systemName: "chevron.down")
                        .opacity((vm.sortOption == .holdings || vm.sortOption == .holdingsResvrsed) ? 1.0 : 0.0 )
                        .rotationEffect(Angle(degrees: vm.sortOption == .holdings ? 0 : 180))
                }
                .onTapGesture {
                    withAnimation(.default) {
                        vm.sortOption = vm.sortOption == .holdings ? .holdingsResvrsed : .holdings
                    }
                }
            }
            Spacer()
            HStack( spacing: 4){
                Text("Price")
             Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .price || vm.sortOption == .priceReversed) ? 1.0 : 0.0 )
                    .rotationEffect(Angle(degrees: vm.sortOption == .price ? 0 : 180))
            }
            .onTapGesture {
                withAnimation(.default) {
                    vm.sortOption = vm.sortOption == .price ? .priceReversed: .price
                }
            }
            
            Button{
                withAnimation(.linear(duration: 2.0)) {
                    vm.reloadingData()
                }
            } label: {
                Image(systemName: "goforward")
                
            }
            .rotationEffect(Angle(degrees: vm.isLoading ? 360 : 0),anchor: .center)
        }
        .font(.caption)
        .foregroundColor(Color.theme.secondarytext)
        .padding(.horizontal)
    }
}
