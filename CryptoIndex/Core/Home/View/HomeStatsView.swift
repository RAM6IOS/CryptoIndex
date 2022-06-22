//
//  HomeStatsView.swift
//  CryptoIndex
//
//  Created by Bouchedoub Rmazi on 24/5/2022.
//

import SwiftUI

struct HomeStatsView: View {
    @EnvironmentObject private var vm : HomeViewModel
    

    @Binding var showPorfolio : Bool
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
        HStack{
            ForEach(vm.statistic) { stat in
                StatisticView(stat: stat)
                    //.frame(width: UIScreen.main.bounds.width / 3)
                    .frame(width: 200, height: 100 )
                
            }
            //
    }
        //.frame(width: UIScreen.main.bounds.width,alignment: showPorfolio ? .trailing : .leading)
        }
        
}
}

struct HomeStatsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeStatsView(showPorfolio: .constant(false))
            .environmentObject(dev.homeVM)
    }
}
