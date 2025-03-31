//
//  Genre.swift
//  WoTV
//
//  Created by Vladyslav Markov on 27.03.2025.
//

import Foundation

struct Genre: Codable, Identifiable, Hashable, Equatable {
    let id: Int
    let name: String
}

struct GenreResponse: Codable {
    let genres: [Genre]
}
