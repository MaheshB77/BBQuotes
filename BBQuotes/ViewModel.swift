//
//  ViewModel.swift
//  BBQuotes
//
//  Created by Mahesh Bansode on 30/12/25.
//

import Foundation

@Observable
@MainActor
class ViewModel {
    private(set) var status: FetchStatus = .notStarted
    private let fetcher = FetchService()
    var quote: Quote
    var character: Char

    // Initialize with sample data
    init() {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let quoteData = try! Data(
            contentsOf: Bundle.main.url(
                forResource: "samplequote",
                withExtension: "json"
            )!
        )
        quote = try! decoder.decode(Quote.self, from: quoteData)

        let charData = try! Data(
            contentsOf: Bundle.main.url(
                forResource: "samplecharacter",
                withExtension: "json"
            )!
        )
        character = try! decoder.decode(Char.self, from: charData)
    }
    
    func getData(for show: String) async {
        status = .fetching
        
        do {
            quote = try await fetcher.fetchQuote(from: show)
            
            character = try await fetcher.fetchCharacter(quote.character)
            
            character.death = try await fetcher.fetchDeath(for: character.name)
            
            status = .success
        } catch {
            status = .failure(error: error)
        }
    }
}

enum FetchStatus {
    case notStarted
    case fetching
    case success
    case failure(error: Error)
}
