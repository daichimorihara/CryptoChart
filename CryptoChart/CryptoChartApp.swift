//
//  CryptoChartApp.swift
//  CryptoChart
//
//  Created by Daichi Morihara on 2022/05/26.
//

import SwiftUI

@main
struct CryptoChartApp: App {
    @StateObject private var vm = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(vm)
        }
    }
}
