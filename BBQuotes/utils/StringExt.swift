//
//  StringExt.swift
//  BBQuotes
//
//  Created by Mahesh Bansode on 31/12/25.
//
import Foundation

extension String {
    func removeSpaces() -> String {
        self.replacingOccurrences(of: " ", with: "")
    }
    
    func removeSpacesAndLowercased() -> String {
        self.removeSpaces().lowercased()
    }
}
