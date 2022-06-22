//
//  SettingsView.swift
//  CryptoIndex
//
//  Created by Bouchedoub Rmazi on 13/6/2022.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismis
    var body: some View {
        NavigationView{
            List{
                Section(header: Text("About App")){
                    VStack(alignment: .leading){
                        Image("cryptoindex")
                            .resizable()
                            .scaledToFit()
                            .frame(height:100 )
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                        Text("Crypto Index - The only tool you need for showcasing, tracking and rebalancing your cryptocurrency investments.Manage your holdings efficiently and calculate how to rebalance your portfolio")
                            .font(.callout)
                            .fontWeight(.medium)
                            .foregroundColor(Color.theme.secondarytext)
                
            }
                    .padding(.vertical)
                    
        }
                
                Section(header: Text("GoinGecko")){
                    VStack(alignment: .leading){
                        Image("coingecko")
                            .resizable()
                            .scaledToFit()
                            .frame(height:100 )
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                        Text("The cryotourency data that is used I this app comes from a free API from CoinGecKa Prices may be slightly delayed")
                            .font(.callout)
                            .fontWeight(.medium)
                            .foregroundColor(Color.theme.secondarytext)
                
            }
                    .padding(.vertical)
                    Link("Visit Apple", destination: URL(string: "https://www.coingecko.com/")!)
        }
                Section(header: Text("About Developer")){
                    VStack(alignment: .leading){
                        Image("Ramzi")
                            .resizable()
                            .scaledToFit()
                            .frame(height:100 )
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                        Text("The app wes developed by Bouchedoub Ramzi,It writtrn 100% in Swiftui and Swiftui")
                            .font(.callout)
                            .fontWeight(.medium)
                            .foregroundColor(Color.theme.secondarytext)
                
            }
                    .padding(.vertical)
                    Link("Vleisit Github", destination: URL(string: "https://github.com/RAM6IOS")!)
                    Link("Vleisit twitter", destination: URL(string: "https://twitter.com/ramzimo44394452")!)
                    
                
        }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("Settings")
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    Button{
                        dismis()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.headline)
                       
                    }
                }
            }
    }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
