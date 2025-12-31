//
//  FetchService.swift
//  BBQuotes
//
//  Created by Mahesh Bansode on 30/12/25.
//

import Foundation

struct FetchService {
    let baseURL = URL(string: Constants.baseUrl)!

    func fetchQuote(from show: String) async throws -> Quote {
        // Build fetch url
        let quoteURL = baseURL.appending(path: "quotes/random")
        let fetchURL = quoteURL.appending(queryItems: [
            URLQueryItem(name: "production", value: show)
        ])

        // Fetch data
        let (data, response) = try await URLSession.shared.data(from: fetchURL)

        // Handle response
        guard let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode == 200
        else {
            throw FetchError.badResponse
        }

        // Decode data
        let decoder = JSONDecoder()
        let quote = try decoder.decode(Quote.self, from: data)

        // Return quote
        return quote
    }

    func fetchCharacter(_ name: String) async throws -> Char {
        let charURL = baseURL.appending(path: "characters")
        let fetchURL = charURL.appending(queryItems: [
            URLQueryItem(name: "name", value: name)
        ])

        let (data, response) = try await URLSession.shared.data(from: fetchURL)

        guard let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode == 200
        else {
            throw FetchError.badResponse
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let characters = try decoder.decode([Char].self, from: data)
        return characters[0]
    }

    func fetchDeath(for character: String) async throws -> Death? {
        let fetchURL = baseURL.appending(path: "deaths")

        let (data, response) = try await URLSession.shared.data(from: fetchURL)

        guard let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode == 200
        else {
            throw FetchError.badResponse
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        let deaths = try decoder.decode([Death].self, from: data)

        for death in deaths {
            if death.character == character {
                return death
            }
        }

        return nil
    }
    
    func fetchEpisode(from show: String) async throws -> Episode? {
        // Build fetch url
        let episodeURL = baseURL.appending(path: "episodes")
        let fetchURL = episodeURL.appending(queryItems: [
            URLQueryItem(name: "production", value: show)
        ])

        // Fetch data
        let (data, response) = try await URLSession.shared.data(from: fetchURL)

        // Handle response
        guard let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode == 200
        else {
            throw FetchError.badResponse
        }

        // Decode data
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let episodes = try decoder.decode([Episode].self, from: data)

        // Return episode
        return episodes.randomElement()
    }
}

enum FetchError: Error {
    case badResponse
}
