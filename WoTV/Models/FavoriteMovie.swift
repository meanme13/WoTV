//
//  FavoriteMovie.swift
//  WoTV
//
//  Created by Vladyslav Markov on 27.03.2025.
//

import Foundation
import SwiftData

@Model
final class FavoriteMovie {
    @Attribute(.unique) var id: Int
    var title: String
    var overview: String
    var posterPath: String?
    var releaseDate: String?
    var voteAverage: Double
    
    init(id: Int, title: String, overview: String, posterPath: String? = nil, releaseDate: String? = nil, voteAverage: Double) {
        self.id = id
        self.title = title
        self.overview = overview
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.voteAverage = voteAverage
    }
}

extension FavoriteMovie {
    func toMovie() -> Movie {
        return Movie(id: id, title: title, overview: overview, posterPath: posterPath, releaseDate: releaseDate, voteAverage: voteAverage)
    }
}
