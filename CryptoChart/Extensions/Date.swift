//
//  Date.swift
//  CryptoChart
//
//  Created by Daichi Morihara on 2022/06/01.
//

import Foundation

// "2022-05-27T02:37:14.822Z"

extension Date {
    
    init(coinGeckoString: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = formatter.date(from: coinGeckoString) ?? Date()
        self.init(timeInterval: 0, since: date)
    }
    
    private var shortFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
    
    func asShortDateString() -> String {
        return self.shortFormatter.string(from: self)
    }
}
