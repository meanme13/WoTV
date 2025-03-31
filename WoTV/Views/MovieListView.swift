//
//  MovieListView.swift
//  WoTV
//
//  Created by Vladyslav Markov on 27.03.2025.
//

import SwiftUI

struct MovieListView: View {
    @StateObject private var viewModel = MovieListViewModel()
    @EnvironmentObject var favoritesViewModel: FavoritesViewModel
    @State private var selectedGenre: Genre? = nil

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading && viewModel.movies.isEmpty {
                    ProgressView("Loading...")
                } else if let error = viewModel.errorMessage {
                    Text("Error: \(error)")
                        .foregroundStyle(.red)
                } else {
                    HStack {
                        Picker("Select genre", selection: $selectedGenre) {
                            Text("All").tag(nil as Genre?)
                            ForEach(viewModel.genres) { genre in
                                Text(genre.name).tag(genre as Genre?)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .onChange(of: selectedGenre) { _, newValue in
                            viewModel.fetchMovies(genre: newValue?.id, reset: true)
                        }
                        
                        Button(action: {
                            viewModel.fetchRandomMovies()
                        }) {
                            Text("Shuffle")
                                .padding(8)
                        }
                        Spacer()
                    }
                    .padding(8)
                    
                    List(viewModel.movies) { movie in
                        NavigationLink(destination: MovieDetailView(movie: movie)
                            .environmentObject(favoritesViewModel)
                        ) {
                            MovieRowView(movie: movie)
                        }
                        .onAppear {
                            if movie == viewModel.movies.last {
                                viewModel.fetchMovies(genre: selectedGenre?.id)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Popular Movies")
            .onAppear {
                if viewModel.movies.isEmpty {
                    viewModel.fetchMovies(reset: true)
                }
                if viewModel.genres.isEmpty {
                    viewModel.fetchGenres()
                }
            }
            .background(Color("PrimaryBackground"))
        }
    }
}


