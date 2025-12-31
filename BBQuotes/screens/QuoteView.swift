//
//  QuoteView.swift
//  BBQuotes
//
//  Created by Mahesh Bansode on 31/12/25.
//

import SwiftUI

struct QuoteView: View {
    let show: String
    let vm = ViewModel()

    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image(show.lowercased().replacingOccurrences(of: " ", with: ""))
                    .resizable()
                    .scaledToFill()

                VStack {
                    Spacer(minLength: 60)
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

                    Button {

                    } label: {
                        Text("New Quote")
                            .tint(.white)
                            .font(.title)
                            .padding(8)
                            .frame(maxWidth: geo.size.width * 0.6)
                            .clipShape(.rect(cornerRadius: 16))
                            .glassEffect()
                    }
                    Spacer(minLength: 92)
                }
                .frame(width: geo.size.width * 0.9)

            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    QuoteView(show: "Breaking Bad")
        .preferredColorScheme(.dark)
}
