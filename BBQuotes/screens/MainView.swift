//
//  MainView.swift
//  BBQuotes
//
//  Created by Mahesh Bansode on 31/12/25.
//

import SwiftUI

struct MainView: View {
    let show: String
    let vm = ViewModel()
    @State var characterDetailsSheet = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image(show.removeSpacesAndLowercased())
                    .resizable()
                    .scaledToFill()
                
                VStack {
                    VStack {
                        Spacer(minLength: 60)
                        switch vm.status {
                        case .notStarted:
                            EmptyView()
                        case .fetching:
                            ProgressView()
                        case .successQuote:
                            Text("\"\(vm.quote.quote)\"")
                                .padding()
                                .background(.black.opacity(0.6))
                                .clipShape(.rect(cornerRadius: 16))
                                .multilineTextAlignment(.center)
                                .minimumScaleFactor(0.5)
                            
                            ZStack(alignment: .bottom) {
                                AsyncImage(url: vm.character.images[0]) { img in
                                    img
                                        .resizable()
                                        .scaledToFill()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(
                                    width: geo.size.width * 0.9,
                                    height: geo.size.height / 1.8
                                )
                                Text(vm.character.name)
                                    .padding(8)
                                    .foregroundStyle(.white)
                                    .frame(maxWidth: .infinity)
                                    .background(.ultraThinMaterial)
                                
                            }
                            .clipShape(.rect(cornerRadius: 16))
                            .padding(.top, 24)
                            .onTapGesture {
                                characterDetailsSheet.toggle()
                            }
                        case .successEpisode:
                            EpisodeView(episode: vm.episode)
                        case .failure(let error):
                            Text("Error: \(error.localizedDescription)")
                        }
                    }
                    .padding(.bottom, 24)
                    
                    HStack {
                        Button {
                            Task {
                                await vm.getQuoteData(for: show)
                            }
                        } label: {
                            Text("Random Quote")
                                .tint(.white)
                                .font(.title)
                                .padding(8)
                                .frame(maxWidth: geo.size.width * 0.8)
                                .clipShape(.rect(cornerRadius: 16))
                                .glassEffect()
                        }
                        Button {
                            Task {
                                await vm.getEpisodeData(for: show)
                            }
                        } label: {
                            Text("Random Episode")
                                .tint(.white)
                                .font(.title)
                                .padding(8)
                                .frame(maxWidth: geo.size.width * 0.8)
                                .clipShape(.rect(cornerRadius: 16))
                                .glassEffect()
                        }
                    }
                    Spacer(minLength: 92)
                }
                .frame(width: geo.size.width * 0.9)
                
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .ignoresSafeArea()
        .sheet(isPresented: $characterDetailsSheet) {
            CharacterView(character: vm.character, show: show)
        }
    }
}

#Preview {
    MainView(show: Constants.bbName)
        .preferredColorScheme(.dark)
}
