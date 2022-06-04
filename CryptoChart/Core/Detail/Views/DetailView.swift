//
//  DetailView.swift
//  CryptoChart
//
//  Created by Daichi Morihara on 2022/05/31.
//

import SwiftUI

struct DetailLoadingView: View {
    
    @Binding var coin: CoinModel?
    
    var body: some View {
        ZStack {
            if let coin = coin {
                DetailView(coin: coin)
            }
        }

    }
}

struct DetailView: View {
    
    @ObservedObject var vm: DetailViewModel
    @State private var showFullDescription = false
    
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    private let spacing: CGFloat = 30
    
    init(coin: CoinModel) {
        self.vm = DetailViewModel(coin: coin)
        print("Initializing Detail View for \(coin.name)")
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                ChartVIew(coin: vm.coin)
                
                VStack(spacing: 20) {                    
                    overviewTitle
                   // Divider()
                    descriptionSection
                    overviewGrid
                    addtionalTitle
                  //  Divider()
                    addtionalGrid
                    websiteSection
                }
                .padding()
            }
        }
        .navigationTitle(vm.coin.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                navigationBarTrailingItem
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(coin: dev.coin)
        }
    }
}

extension DetailView {
    
    var navigationBarTrailingItem: some View {
        HStack {
            Text(vm.coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(.theme.accent)
            
            CoinImageView(coin: vm.coin)
                .frame(width: 25, height: 25)
        }
    }
    
    
    var overviewTitle: some View {
        Text("Overview")
            .font(.title)
            .bold()
            .foregroundColor(.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var overviewGrid: some View {
        LazyVGrid(columns: columns,
                  alignment: .leading,
                  spacing: spacing,
                  pinnedViews: [],
                  content: {
            ForEach(vm.overviewStatistics) { stat in
                StatisticView(stat: stat)
            }
        })
    }
    
    var addtionalTitle: some View {
        Text("Additional Details")
            .font(.title)
            .bold()
            .foregroundColor(.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var addtionalGrid: some View {
        LazyVGrid(columns: columns,
                  alignment: .leading,
                  spacing: spacing,
                  pinnedViews: [],
                  content: {
            ForEach(vm.additionalStatistics) { stat in
                StatisticView(stat: stat)
            }
        })
    }
    
    var descriptionSection: some View {
        ZStack {
            if let coinDescription = vm.coinDescription,
               !coinDescription.isEmpty {
                
                VStack(alignment: .leading) {
                    Text(coinDescription.removingHTMLOccurances)
                        .font(.callout)
                        .foregroundColor(.theme.secondaryText)
                        .lineLimit(showFullDescription ? nil : 3)

                    Button {
                        withAnimation {
                            showFullDescription.toggle()
                        }
                    } label: {
                        Text(showFullDescription ? "Less" : "Read more...")
                            .font(.caption)
                            .fontWeight(.bold)
                            .padding(.top, 2)
                            .foregroundColor(.blue)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    
    var websiteSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            if let websiteURLString = vm.websiteURL,
               let websiteURL = URL(string: websiteURLString) {
                Link("Website", destination: websiteURL)
            }
            if let redditURLString = vm.reditURL,
               let redditURL = URL(string: redditURLString) {
                Link("Reddit", destination: redditURL)
            }
        }
        .foregroundColor(.blue)
        .frame(maxWidth: .infinity, alignment: .leading)
        .font(.headline)
    }
}
