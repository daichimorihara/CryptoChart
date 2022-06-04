//
//  LaunchView.swift
//  CryptoChart
//
//  Created by Daichi Morihara on 2022/06/02.
//

import SwiftUI

struct LaunchView: View {
    
    private let loadingText: [String] = "Loading your portfolio...".map{ String($0) }
    @State private var showLoadingText: Bool = false
    let timer = Timer.publish(every: 0.08, on: .main, in: .common).autoconnect()
    
    @State private var counter: Int = 0
    @State private var loops: Int = 0
    @Binding var showLaunchView: Bool
    
    var body: some View {
        ZStack {
            Color.launch.background
                .ignoresSafeArea()
            
            Image("logo-transparent")
            
            ZStack {
                if showLoadingText {
                    HStack(spacing: 0) {
                        ForEach(0..<loadingText.count) { idx in
                            Text(loadingText[idx])
                                .font(.headline)
                                .foregroundColor(.launch.accent)
                                .fontWeight(.heavy)
                                .offset(y: idx == counter ? -5 : 0)

                        }
                    }
                    .transition(AnyTransition.scale.animation(.easeIn))
                }
            }
            .offset(y: 70)
        }
        .onAppear {
            showLoadingText = true
        }
        .onReceive(timer, perform: { _ in
            withAnimation {
                if counter == loadingText.count - 1 {
                    counter = 0
                    loops += 1
                    if loops >= 2 {
                        showLaunchView = false
                    }
                }
                counter += 1
            }
        })
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(showLaunchView: .constant(true))
    }
}
