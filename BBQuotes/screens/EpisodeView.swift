//
//  EpisodeView.swift
//  BBQuotes
//
//  Created by Mahesh Bansode on 31/12/25.
//

import SwiftUI

struct EpisodeView: View {
    let episode: Episode
    var body: some View {
        VStack(alignment: .leading) {
            Text(episode.title)
                .font(.largeTitle)
                .padding(.top)
            Text(episode.seasonEpisode)
            
            AsyncImage(url: episode.image) { img in
                img
                    .resizable()
                    .scaledToFit()
                    .clipShape(.rect(cornerRadius: 16))
            } placeholder: {
                ProgressView()
                    .frame(maxWidth: .infinity, minHeight: 200)
            }
            
            Text(episode.synopsis)
                .padding(.top, 8)
            
            Text("Written By: \(episode.writtenBy)")
                .padding(.top, 8)
            Text("Directed By: \(episode.directedBy)")
            Text("Air Date: \(episode.airDate)")
                .padding(.bottom)
        }
        .padding(.horizontal, 16)
        .background(.black.opacity(0.6))
        .clipShape(.rect(cornerRadius: 16))
    }
}

#Preview {
    EpisodeView(episode: ViewModel().episode)
}
