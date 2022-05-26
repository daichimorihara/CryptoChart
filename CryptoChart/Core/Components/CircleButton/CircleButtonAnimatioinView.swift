//
//  CircleButtonAnimatioinView.swift
//  CryptoChart
//
//  Created by Daichi Morihara on 2022/05/26.
//

import SwiftUI

struct CircleButtonAnimatioinView: View {
    
    @Binding var animate: Bool
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 5)
            .scale(animate ? 1.0 : 0.0)
            .opacity(animate ? 0.0 : 1.0)
            .animation(animate ? .easeOut(duration: 1.0) : .none)

    }
        
}

struct CircleButtonAnimatioinView_Previews: PreviewProvider {
    static var previews: some View {
        CircleButtonAnimatioinView(animate: .constant(false))
            
    }
}
