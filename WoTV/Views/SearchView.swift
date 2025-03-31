//
//  SearchView.swift
//  WoTV
//
//  Created by Vladyslav Markov on 27.03.2025.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBarView(text: $searchText)
                    .onChange(of: searchText) { _, newValue in
                        viewModel.searchMovies(query: newValue)
                    }
                
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let error = viewModel.errorMessage {
                    Text("Error occurred: \(error)")
                        .foregroundStyle(.red)
                } else {
                    List(viewModel.movies) { movie in
                        NavigationLink(destination: MovieDetailView(movie: movie)) {
                            MovieRowView(movie: movie)
                        }
                    }
                }
            }
            .navigationTitle("Search")
            .background(Color("PrimaryBackground"))
        }
    }
}

#Preview {
    SearchView()
}
