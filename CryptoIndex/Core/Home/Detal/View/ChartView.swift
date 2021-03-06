//
//  ChartView.swift
//  CryptoIndex
//
//  Created by Bouchedoub Rmazi on 10/6/2022.
//
//import Charts
import SwiftUI

struct ChartView: View {
    let data:[Double]
    let maxY: Double
    let minY: Double
    let lineColor:Color
    let startingDate : Date
    let endingDate : Date
    @State var persentage :CGFloat = 0
    
    
    init(coin:CoinModel){
        data = coin.sparklineIn7D?.price ?? []
        maxY = data.max() ?? 0
        minY = data.min() ?? 0
        
        let priceChange = (data.first ?? 0) - (data.last ?? 0)
        lineColor = priceChange > 0 ? Color.theme.red : Color.theme.green
        //lineColor =  coin.priceChangePercentage24H ?? 0 >= 0 ? Color.theme.green  : Color.theme.red
        endingDate = Date(coinGeckoString: coin.lastUpdated ?? "")
        startingDate = endingDate.addingTimeInterval(-7*24*60*60)
    }
    var body: some View {
        VStack{
        GeometryReader { geomtry in
            Path { path in
                for index  in data.indices{
                    let xPosition = geomtry.size.width / CGFloat(data.count) * CGFloat(index + 1)
                    let yAxis = maxY - minY
                    let yPosition = (1 - CGFloat((data[index] - minY) / yAxis)) * geomtry.size.height
                    if index == 0 {
                        path.move(to: CGPoint(x:xPosition , y:yPosition))
                    }
                    path.addLine(to: CGPoint(x:xPosition ,y:yPosition))
                }
                
            }
            .trim(from:0, to:persentage )
            .stroke(lineColor ,  style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
            .shadow(color: lineColor, radius: 10, x: 0.0, y: 10)
            
        }
        .frame( height: 300)
        .background{
            VStack{
                Divider()
                Spacer()
                Divider()
                Spacer()
                Divider()
            }
        }
        .overlay(
            VStack{
            Text(maxY.formattedWithAbbreviations())
            Spacer()
            Text(((maxY + minY) / 2).formattedWithAbbreviations())
            Spacer()
            Text(minY.formattedWithAbbreviations())
            }
                .padding(.horizontal , 4)
            ,alignment: .leading)
        HStack{
            Text(startingDate.asShortDateString())
            Spacer()
            Text(endingDate.asShortDateString())
        }
        }
        .font(.caption)
        .foregroundColor(Color.theme.secondarytext)
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline:.now() + 0.2) {
                withAnimation(.linear(duration: 2.0)){
                    persentage = 1.0
                }
            }
        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(coin: dev.coin)
    }
}
