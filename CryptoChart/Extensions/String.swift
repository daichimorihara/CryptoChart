//
//  String.swift
//  CryptoChart
//
//  Created by Daichi Morihara on 2022/06/01.
//

import Foundation

extension String {
    
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>",
                                         with: "",
                                         options: .regularExpression,
                                         range: nil)
    }
}
