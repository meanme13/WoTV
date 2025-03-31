//
//  MovieListViewModel.swift
//  WoTV
//
//  Created by Vladyslav Markov on 27.03.2025.
//

import Foundation

class MovieListViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var genres: [Genre] = []

    private var currentPage = 1
    private var canLoadMore = true
    private var selectedGenre: Int? = nil
    
    func fetchMovies(genre: Int? = nil, reset: Bool = false) {
        guard !isLoading else { return }
        
        if reset {
            currentPage = 1
            movies.removeAll()
        }
        
        isLoading = true
        errorMessage = nil

        var urlString = "https://api.themoviedb.org/3/discover/movie?api_key=\(Constants.apiKey)&language=en-US&sort_by=popularity.desc&page=\(currentPage)"
        
        if let genreId = genre {
            urlString += "&with_genres=\(genreId)"
        }

        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }

            if let data = data {
                do {
                    let movieResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.isLoading = false
                        self.movies.append(contentsOf: movieResponse.results)
                        self.currentPage += 1
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.isLoading = false
                        self.errorMessage = error.localizedDescription
                    }
                }
            } else if let error = error {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.errorMessage = error.localizedDescription
                }
            }
        }
        .resume()
    }

    
    func fetchRandomMovies() {
        guard !isLoading else { return }
        
        isLoading = true
        errorMessage = nil
        
        let randomPage = Int.random(in: 1...500)
        let urlString = "https://api.themoviedb.org/3/discover/movie?api_key=\(Constants.apiKey)&language=en-US&sort_by=popularity.desc&page=\(randomPage)"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            
            if let data = data {
                do {
                    let movieResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
                    let shuffledMovies = Array(movieResponse.results.shuffled().prefix(10))
                    
                    DispatchQueue.main.async {
                        self.isLoading = false
                        self.movies = shuffledMovies
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.isLoading = false
                        self.errorMessage = error.localizedDescription
                    }
                }
            } else if let error = error {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.errorMessage = error.localizedDescription
                }
            }
        }
        .resume()
    }

    
    func fetchGenres() {
        guard let url = URL(string: "https://api.themoviedb.org/3/genre/movie/list?api_key=\(Constants.apiKey)&language=en-US")
        else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let genreResponse = try JSONDecoder().decode(GenreResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.genres = genreResponse.genres
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.errorMessage = "Failed to load genres: \(error.localizedDescription)"
                    }
                }
            }
        }
        .resume()
    }
}
