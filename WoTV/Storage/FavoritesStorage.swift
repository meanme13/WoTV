//
//  FavoritesStorage.swift
//  WoTV
//
//  Created by Vladyslav Markov on 27.03.2025.
//

import Foundation
import SwiftData

final class FavoritesStorage {
    private let container: ModelContainer
    
    init(container: ModelContainer) {
        self.container = container
    }
    
    func saveFavoriteMovie(_ movie: Movie) {
        let favoriteMovie = FavoriteMovie(
            id: movie.id,
            title: movie.title,
            overview: movie.overview,
            posterPath: movie.posterPath,
            releaseDate: movie.releaseDate,
            voteAverage: movie.voteAverage
        )
        
        Task { @MainActor in
            do  {
                container.mainContext.insert(favoriteMovie)
                try container.mainContext.save()
            } catch {
                print("Error saving favorite movie: \(error)")
            }
        }
    }
    
    @MainActor func getFavoriteMovies() -> [FavoriteMovie] {
        do {
            let fetchDescriptor = FetchDescriptor<FavoriteMovie>()
            let favoriteMovies = try container.mainContext.fetch(fetchDescriptor)
            return favoriteMovies
        } catch {
            print("Error fetching favorite movies: \(error)")
            return []
        }
    }
    
    func removeFavoriteMovie(_ movie: FavoriteMovie) {
        Task { @MainActor in
            do {
                container.mainContext.delete(movie)
                try container.mainContext.save()
            } catch {
                print("Error removing favorite movie: \(error)")
            }
        }
    }
}
