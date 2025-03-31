//
//  Actor.swift
//  WoTV
//
//  Created by Vladyslav Markov on 27.03.2025.
//

import Foundation

struct Actor: Identifiable, Codable {
    let id: Int
    let name: String
    let profilePath: String?
    
    var profileURL: URL? {
        guard let path = profilePath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
    }
}

struct CastResponse: Codable {
    let cast: [Actor]
}
