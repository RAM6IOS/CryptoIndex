//
//  CryptoIndexApp.swift
//  CryptoIndex
//
//  Created by Bouchedoub Rmazi on 8/5/2022.
//

import SwiftUI

@main
struct CryptoIndexApp: App {
    
@StateObject private var vm = HomeViewModel()
    var body: some Scene {
        WindowGroup { 
            NavigationView{
            HomeView()
                    .navigationBarHidden(true)
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .environmentObject(vm)
        }
    }
}
