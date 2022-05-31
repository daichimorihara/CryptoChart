//
//  HapticManager.swift
//  CryptoChart
//
//  Created by Daichi Morihara on 2022/05/31.
//

import Foundation
import SwiftUI

class HapticManager {
    
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}
