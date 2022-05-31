//
//  SearchBarView.swift
//  CryptoChart
//
//  Created by Daichi Morihara on 2022/05/28.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    @FocusState var nameIsFocused: Bool
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(searchText.isEmpty ? .theme.secondaryText : .theme.accent)
            
            TextField("Search by name or symbol...", text: $searchText)
                .foregroundColor(.theme.accent)
                .disableAutocorrection(true)
                .focused($nameIsFocused)

        }
        .overlay(
            Image(systemName: "xmark.circle.fill")
                .padding()
                .foregroundColor(.theme.accent)
                .opacity(searchText.isEmpty ? 0.0 : 1.0)
                .onTapGesture {
                    searchText = ""
                    nameIsFocused = false
                }
            
            ,alignment: .trailing
        )
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.theme.background)
                .shadow(color: Color.theme.accent.opacity(0.2),
                        radius: 10, x: 0, y: 0)
        )
        .padding()
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SearchBarView(searchText: .constant(""))
                .previewLayout(.sizeThatFits)
            
            SearchBarView(searchText: .constant(""))
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)

        }
    }
}
