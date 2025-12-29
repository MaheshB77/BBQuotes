//
//  ContentView.swift
//  BBQuotes
//
//  Created by Mahesh Bansode on 29/12/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Breaking Bad", systemImage: "tortoise") {
                Text("Breaking Bad Quotes")

            }

            Tab("Better Call Saul", systemImage: "briefcase") {
                Text("Better Call Saul Quotes")

            }
        }
        .preferredColorScheme(.dark)
    }
        
}

#Preview {
    ContentView()
}
