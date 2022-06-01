//
//  DetailVIewModel.swift
//  CryptoChart
//
//  Created by Daichi Morihara on 2022/06/01.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    
    @Published var overviewStatistics = [StatisticModel]()
    @Published var additionalStatistics = [StatisticModel]()
    
    @Published var coin: CoinModel
    private let coinDetailService: CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coin = coin
        self.coinDetailService = CoinDetailDataService(coin: coin)
        addSubscribers()
    }
    
    private func addSubscribers() {
        coinDetailService.$coinDetail
            .combineLatest($coin)
            .map(mapDataToStatistics)
            .sink(receiveValue: { [weak self] returnedArray in
                self?.overviewStatistics = returnedArray.overview
                self?.additionalStatistics = returnedArray.additional
            })
            .store(in: &cancellables)
    }
    
    
    private func mapDataToStatistics(coinDetailModel: CoinDetailModel?, coinModel: CoinModel) -> (overview: [StatisticModel], additional: [StatisticModel]) {
        
        let overviewArray = mapDataToOverviewArray(coinModel: coinModel)
        let additionalArray = mapDataToAddtionalArray(coinDetailModel: coinDetailModel, coinModel: coinModel)
        
        return (overviewArray, additionalArray)
    }
    
    private func mapDataToOverviewArray(coinModel: CoinModel) -> [StatisticModel] {
        // overview
        let price = coinModel.currentPrice.asCurrencyWith6Decimals()
        let priceChange1 = coinModel.priceChangePercentage24H
        let priceStat = StatisticModel(title: "Current Price", value: price, percentageChange: priceChange1)
        
        let marketCap = "$" + (coinModel.marketCap?.formattedWithAbbreveations() ?? "")
        let marketCapChange = coinModel.marketCapChangePercentage24H
        let marketCapStat = StatisticModel(title: "Market Cap", value: marketCap, percentageChange: marketCapChange)
        
        let rank = "\(coinModel.rank)"
        let rankStat = StatisticModel(title: "Rank", value: rank)
        
        let volume = "$" + (coinModel.totalVolume?.formattedWithAbbreveations() ?? "")
        let volumeStat = StatisticModel(title: "Volume", value: volume)
        
        let overviewArray: [StatisticModel] = [
            priceStat, marketCapStat, rankStat, volumeStat
        ]
        
        return overviewArray
    }
    
    private func mapDataToAddtionalArray(coinDetailModel: CoinDetailModel?, coinModel: CoinModel) -> [StatisticModel] {
        // additional
        let high = coinModel.high24H?.asCurrencyWith6Decimals() ?? "n/a"
        let highStat = StatisticModel(title: "24h High", value: high)
        
        let low = coinModel.low24H?.asCurrencyWith6Decimals() ?? "n/a"
        let lowStat = StatisticModel(title: "24h High", value: low)
        
        let priceChange = coinModel.priceChange24H?.asCurrencyWith6Decimals() ?? "n/a"
        let pricePercentChange2 = coinModel.priceChangePercentage24H
        let priceChangeStat = StatisticModel(title: "24h Price Change", value: priceChange, percentageChange: pricePercentChange2)
        
        let marketCapChange2 = "$" + (coinModel.marketCapChange24H?.formattedWithAbbreveations() ?? "")
        let marketCapPercentChange2 = coinModel.marketCapChangePercentage24H
        let marketCapChangeStat = StatisticModel(title: "34h Market Cap Change", value: marketCapChange2, percentageChange: marketCapPercentChange2)
        
        let blockTime = coinDetailModel?.blockTimeInMinutes ?? 0
        let blockTimeString = blockTime == 0 ? "n/a" : "\(blockTime)"
        let blockTimeStat = StatisticModel(title: "Block Time", value: blockTimeString)
        
        let hashing = coinDetailModel?.hashingAlgorithm ?? "n/a"
        let hashingStat = StatisticModel(title: "Hashing Algorithm", value: hashing)
        
        
        
        let additionalArray: [StatisticModel] = [
            highStat,lowStat, priceChangeStat, marketCapChangeStat,
            blockTimeStat, hashingStat
        ]
        
        return additionalArray
    }
}
