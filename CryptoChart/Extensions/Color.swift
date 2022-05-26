//
//  Color.swift
//  CryptoChart
//
//  Created by Daichi Morihara on 2022/05/26.
//

import Foundation
import SwiftUI

extension Color {
    
    static let theme = ColorTheme()
}


struct ColorTheme {
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let green = Color("GreenColor")
    let red = Color("RedColor")
    let secondaryText = Color("SecondaryTextColor")
}
