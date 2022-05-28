//
//  CoinImageView.swift
//  CryptoChart
//
//  Created by Daichi Morihara on 2022/05/28.
//

import SwiftUI

struct CoinImageView: View {
    @ObservedObject var vm: CoinImageViewModel
    
    let coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        vm = CoinImageViewModel(coin: coin)
    }
    
    var body: some View {
        ZStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if vm.isLoading {
                ProgressView()
            } else {
                Image(systemName: "questionmark")
                    .foregroundColor(.theme.secondaryText)
            }
        }
    }
}

struct CoinImageView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CoinImageView(coin: dev.coin)
                
                
        }
    }
}
