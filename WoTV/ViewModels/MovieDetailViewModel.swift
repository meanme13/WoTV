//
//  MovieDetailViewModel.swift
//  WoTV
//
//  Created by Vladyslav Markov on 27.03.2025.
//

import Foundation

class MovieDetailViewModel: ObservableObject {
    @Published var actors: [Actor] = []
    @Published var trailerKey: String?
    
    func fetchMovieDetails(movieId: Int) {
        fetchActors(movieId: movieId)
        fetchTrailer(movieId: movieId)
    }
    
    private func fetchActors(movieId: Int) {
        let urlString = "https://api.themoviedb.org/3/movie/\(movieId)/credits?api_key=\(Constants.apiKey)&language=en-US"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self, let data = data else { return }
            
            do {
                let response = try JSONDecoder().decode(CastResponse.self, from: data)
                DispatchQueue.main.async {
                    self.actors = response.cast
                }
            } catch {
                print("Error decoding actors: \(error)")
            }
        }
        .resume()
    }
    
    private func fetchTrailer(movieId: Int) {
        let urlString = "https://api.themoviedb.org/3/movie/\(movieId)/videos?api_key=\(Constants.apiKey)&language=en-US"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self, let data = data else { return }
            
            do {
                let response = try JSONDecoder().decode(VideoResponse.self, from: data)
                DispatchQueue.main.async {
                    self.trailerKey = response.results.first(where: { $0.site == "YouTube" })?.key
                }
            } catch {
                print("Error decoding trailer: \(error)")
            }
        }
        .resume()
    }
}

struct VideoResponse: Codable {
    let results: [Video]
}

struct Video: Codable {
    let key: String
    let site: String
}
