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
                    AsyncImage(url: character.images[0]) { img in
                        img
                            .resizable()
                            .scaledToFit()
                            .clipShape(.rect(cornerRadius: 16))
                    } placeholder: {
                        ProgressView()
                    }
                    .padding(.top, 60)

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

                    }
                    .frame(width: geo.size.width * 0.8, alignment: .leading)

                }
                .frame(width: geo.size.width * 0.9)
                .padding(.bottom)
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    CharacterView(character: ViewModel().character, show: "Breaking Bad")
}
