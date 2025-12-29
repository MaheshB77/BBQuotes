//
//  Death.swift
//  BBQuotes
//
//  Created by Mahesh Bansode on 29/12/25.
//

import Foundation

struct Death: Decodable {
    let character: String
    let image: URL
    let details: String
    let lastWords: [String]
}
