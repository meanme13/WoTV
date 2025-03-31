//
//  FavoritesViewModel.swift
//  WoTV
//
//  Created by Vladyslav Markov on 27.03.2025.
//

import Foundation
import SwiftData

class FavoritesViewModel: ObservableObject {
    @Published private(set) var favoriteMovies: [FavoriteMovie] = []
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
        fetchFavorites()
    }

    func fetchFavorites() {
        let descriptor = FetchDescriptor<FavoriteMovie>()
        do {
            favoriteMovies = try context.fetch(descriptor)
        } catch {
            print("Error fetching favorites: \(error)")
        }
    }

    func toggleFavorite(_ movie: Movie) {
        if let existingMovie = favoriteMovies.first(where: { $0.id == movie.id }) {
            context.delete(existingMovie)
        } else {
            let newFavorite = FavoriteMovie(
                id: movie.id,
                title: movie.title,
                overview: movie.overview,
                posterPath: movie.posterPath,
                releaseDate: movie.releaseDate,
                voteAverage: movie.voteAverage
            )
            context.insert(newFavorite)
        }
        do {
            try context.save()
            fetchFavorites()
            objectWillChange.send()
        } catch {
            print("Error saving favorites: \(error)")
        }
    }

    func isFavorite(_ movie: Movie) -> Bool {
        return favoriteMovies.contains { $0.id == movie.id }
    }
}
