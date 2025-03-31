//
//  SearchViewModel.swift
//  WoTV
//
//  Created by Vladyslav Markov on 29.03.2025.
//

import Foundation

class SearchViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func searchMovies(query: String) {
        guard !query.isEmpty else {
            movies = []
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        APIService.shared.searchMovies(query: query) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isLoading = false
                
                switch result {
                    case .success(let movies):
                    self.movies = movies
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
