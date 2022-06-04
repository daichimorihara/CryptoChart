//
//  ChartVIew.swift
//  CryptoChart
//
//  Created by Daichi Morihara on 2022/06/01.
//

import SwiftUI

struct ChartVIew: View {
    
    let data: [Double]
    let maxY: Double
    let minY: Double
    let lineColor: Color
    let startingDate: Date
    let endingDate: Date
    @State private var percentage: CGFloat = 0
    
    var yAxis: Double {
        maxY - minY
    }
    
    init(coin: CoinModel) {
        self.data = coin.sparklineIn7D?.price ?? []
        self.maxY = data.max() ?? 0
        self.minY = data.min() ?? 0
        let priceChange = (data.last ?? 0) - (data.first ?? 0)
        self.lineColor = priceChange < 0 ? Color.theme.red : Color.theme.green
        
        self.endingDate = Date(coinGeckoString: coin.lastUpdated ?? "")
        self.startingDate = endingDate.addingTimeInterval(-7*24*60*60)
        
    }
    
    var body: some View {

        VStack {
            chartView
                .frame(height: 200)
                .background(chartBackground)
                .overlay(chartYAxis,alignment: .leading)
            
            chartDateLabels
        }
        .font(.caption)
        .foregroundColor(.theme.secondaryText)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.linear(duration: 1.0)) {
                    percentage = 1.0
                }
            }

        }

    }
}

struct ChartVIew_Previews: PreviewProvider {
    static var previews: some View {
        ChartVIew(coin: dev.coin)
    }
}

extension ChartVIew {
    var chartView: some View {
        GeometryReader { geometry in
            Path { path in
                for idx in data.indices {
                    let xPosition = geometry.size.width / CGFloat(data.count) * CGFloat(idx + 1)
                    
                    let yPosition = CGFloat(1 - (data[idx] - minY) / yAxis) * geometry.size.height
                    
                    if idx == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    }
                    path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                    
                }
                
            }
            .trim(from: 0, to: percentage)
            .stroke(lineColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
            .shadow(color: lineColor, radius: 10, x: 0.0, y: 10)
        }
    }
    
    var chartBackground: some View {
        VStack {
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
        }
    }
    
    var chartYAxis: some View {
        VStack {
            Text(maxY.formattedWithAbbreveations())
            Spacer()
            let price = (maxY + minY) / 2
            Text(price.formattedWithAbbreveations())
            Spacer()
            Text(minY.formattedWithAbbreveations())
        }
    }
    
    var chartDateLabels: some View {
        HStack {
            Text(startingDate.asShortDateString())
            Spacer()
            Text(endingDate.asShortDateString())
        }
    }
}
