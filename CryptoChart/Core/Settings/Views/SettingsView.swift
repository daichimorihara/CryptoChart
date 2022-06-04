//
//  SettingsView.swift
//  CryptoChart
//
//  Created by Daichi Morihara on 2022/06/02.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.dismiss) var dismiss
    
    let twitterURL = URL(string: "https://twitter.com/JlCJW1eaz8r4sdR")!
    
    var body: some View {
        NavigationView {
            List {
                devInfo
                secondSection
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    xMarkButton
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

extension SettingsView {
    var xMarkButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
        }
    }
    
    var devInfo: some View {
        Section {
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 10) {
                    Image("Daichi")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                        .overlay(Circle()
                            .stroke()
                            .foregroundColor(.gray)
                        )
                    Text("金大地")
                        .font(.title)
                        .fontWeight(.bold)
                }
                Text("Q. Who is 金大地?")
                    .font(.headline)
                    
                Text("A. He is a amateur iOS developer.")

                Link("@Twitter", destination: twitterURL)
                    .foregroundColor(.blue)
            }
            .foregroundColor(.theme.accent)
            
        } header: {
            Text("DEVELOPER INFO")
        }
    }
    
    var secondSection: some View {
        Section {
            Text("このアプリを購入していただけませんか？")
        } header: {
            Text("DEAR 川原田")
        }
    }
}


