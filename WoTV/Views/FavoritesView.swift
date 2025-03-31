//
//  FavoritesView.swift
//  WoTV
//
//  Created by Vladyslav Markov on 27.03.2025.
//

import SwiftUI
import SwiftData

struct FavoritesView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(filter: #Predicate<FavoriteMovie> { _ in true }) private var favoriteMovies: [FavoriteMovie]
    @EnvironmentObject var favoritesViewModel: FavoritesViewModel

    var body: some View {
        NavigationView {
            List {
                ForEach(favoriteMovies) { movie in
                    NavigationLink(destination: MovieDetailView(movie: movie.toMovie())) {
                        MovieRowView(movie: movie.toMovie())
                    }
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        let favoriteMovie = favoriteMovies[index]
                        let movie = Movie(
                            id: favoriteMovie.id,
                            title: favoriteMovie.title,
                            overview: favoriteMovie.overview,
                            posterPath: favoriteMovie.posterPath,
                            releaseDate: favoriteMovie.releaseDate,
                            voteAverage: favoriteMovie.voteAverage
                        )
                        favoritesViewModel.toggleFavorite(movie)
                    }
                }
            }
            .navigationTitle("Favorites")
            .onAppear {
                try? modelContext.save()
            }
            .background(Color("PrimaryBackground"))
        }
    }

    private func deleteMovies(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(favoriteMovies[index])
        }
    }
}
