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
            Tab(Constants.bbName, systemImage: "tortoise") {
                MainView(show: Constants.bbName)

            }

            Tab(Constants.bcsName, systemImage: "briefcase") {
                MainView(show: Constants.bcsName)
            }
            
            Tab(Constants.ecName, systemImage: "car") {
                MainView(show: Constants.ecName)
            }
        }
        .preferredColorScheme(.dark)
    }
        
}

#Preview {
    ContentView()
}
