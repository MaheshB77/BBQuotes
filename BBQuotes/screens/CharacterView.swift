//
//  CharacterView.swift
//  BBQuotes
//
//  Created by Mahesh Bansode on 31/12/25.
//

import SwiftUI

struct CharacterView: View {
    let character: Char
    let show: String
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .top) {
                Image(show.lowercased().replacingOccurrences(of: " ", with: ""))
                    .resizable()
                    .scaledToFit()

                ScrollView {
                    TabView {
                        ForEach(character.images, id: \.self) { imgURL in
                            
                            AsyncImage(url: imgURL) { img in
                                img
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(.rect(cornerRadius: 16))
                            } placeholder: {
                                ProgressView()
                            }
                            .padding(.top, 60)
                        }
                    }
                    .tabViewStyle(.page)
                    .frame(height: geo.size.height * 0.6)

                    VStack(alignment: .leading) {

                        Text(character.name)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Text("Portrayed by: \(character.portrayedBy)")
                        Divider()

                        Text("\(character.name)'s Details")
                            .font(.title2)
                        Text("Born: \(character.birthday)")
                        Divider()

                        Text("Occupations: ")
                        ForEach(character.occupations, id: \.self) {
                            occupation in
                            Text("• \(occupation)")
                                .font(.subheadline)
                        }
                        Divider()

                        Text("Nicknames: ")
                        if !character.aliases.isEmpty {

                            ForEach(character.aliases, id: \.self) { alias in
                                Text("• \(alias)")
                                    .font(.subheadline)
                            }
                        } else {
                            Text("None")
                        }
                        Divider()
                        
                        DisclosureGroup("Status: (spoiler alert!)") {
                            VStack {
                                Text(character.status)
                                    .font(.title2)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            if let death = character.death {
                                AsyncImage(url: death.image) { img in
                                    img
                                        .resizable()
                                        .scaledToFit()
                                        .clipShape(.rect(cornerRadius: 16))
                                } placeholder: {
                                    ProgressView()
                                }
                                
                                Text("Cause of Death: \(death.details)")
                                    .padding(.bottom, 8)
                                
                                Text("Last Words: \(death.lastWords)")
                            }
                        }
                        .foregroundStyle(.primary)
                    }
                    .frame(width: geo.size.width * 0.8, alignment: .leading)

                }
                .frame(width: geo.size.width * 0.9)
                .padding(.bottom)
                .scrollIndicators(.hidden)
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    CharacterView(character: ViewModel().character, show: "Breaking Bad")
}
