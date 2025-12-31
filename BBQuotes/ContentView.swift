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
                QuoteView(show: "Breaking Bad")

            }

            Tab("Better Call Saul", systemImage: "briefcase") {
                QuoteView(show: "Better Call Saul")
            }
            
            Tab("EL Camino", systemImage: "car") {
                QuoteView(show: "El Camino")
            }
        }
        .preferredColorScheme(.dark)
    }
        
}

#Preview {
    ContentView()
}
