//
//  MarketDataModel.swift
//  CryptoChart
//
//  Created by Daichi Morihara on 2022/05/29.
//

import Foundation
import Foundation

// JSON data:
/*
 
 URL: https://api.coingecko.com/api/v3/global
 
 JSON Response:
 {
   "data": {
     "active_cryptocurrencies": 7115,
     "upcoming_icos": 0,
     "ongoing_icos": 50,
     "ended_icos": 3375,
     "markets": 610,
     "total_market_cap": {
       "btc": 43945962.151456155,
       "eth": 652788081.2710718,
       "ltc": 6495993714.950187,
       "bch": 1770500224.7357078,
     },
     "total_volume": {
       "btc": 5838405.376372819,
       "eth": 86725634.31857495,
       "ltc": 863020008.5172676,
       "bch": 235218380.1401587,
     },
     "market_cap_percentage": {
       "btc": 42.56418169927073,
       "eth": 17.740741095283088,
       "bnb": 4.052168800333709,
       "doge": 2.8545041970901375,
     },
     "market_cap_change_percentage_24h_usd": 0.5446264306552537,
     "updated_at": 1620607846
   }
 }
 
 
 */

struct GlobalData: Codable {
    let data: MarketDataModel?
}

struct MarketDataModel: Codable {
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double
    
    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }
    
    var marketCap: String {
        if let item = totalMarketCap.first(where: { $0.key == "usd" }) {
            return "$" + item.value.formattedWithAbbreveations()
        }
        return ""
    }
    
    var volume: String {
        if let item = totalVolume.first(where: { $0.key == "usd" }) {
            return "$" + item.value.formattedWithAbbreveations()
        }
        return ""
    }
    
    var btcDominance: String {
        if let item = marketCapPercentage.first(where: { $0.key == "btc" }) {
            return item.value.asPercentageString()
        }
        return ""
    }
}

