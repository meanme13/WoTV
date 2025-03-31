//
//  MovieDetailView.swift
//  WoTV
//
//  Created by Vladyslav Markov on 27.03.2025.
//

import SwiftData
import SwiftUI
import WebKit

struct MovieDetailView: View {
    let movie: Movie
    @StateObject private var viewModel = MovieDetailViewModel()
    @EnvironmentObject var favoritesViewModel: FavoritesViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                AsyncImage(url: movie.posterURL) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
                .frame(maxWidth: .infinity)
                .clipped()
                
                HStack {
                    Text(movie.title)
                        .font(.largeTitle)
                        .bold()
                    
                    Spacer()
                    
                    Button(action: {
                        favoritesViewModel.toggleFavorite(movie)
                    }) {
                        Image(systemName: favoritesViewModel.isFavorite(movie) ? "heart.fill" : "heart")
                            .foregroundColor(.red)
                    }
                }
                
                HStack {
                    Text("⭐️ \(String(format: "%.1f", movie.voteAverage))")
                        .font(.headline)
                    Text("(\(movie.voteAverage) votes)")
                        .foregroundStyle(.gray)
                }
                
                Text(movie.overview)
                    .font(.body)
                    .padding(.vertical)
                
                if let trailerKey = viewModel.trailerKey {
                    Text("Trailer")
                        .font(.title2)
                        .bold()
                    
                    YouTubeView(videoID: trailerKey)
                        .frame(height: 200)
                        .padding(.bottom)
                }
                
                if !viewModel.actors.isEmpty {
                    Text("Actors")
                        .font(.title2)
                        .bold()
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(viewModel.actors) { actor in
                                VStack {
                                    if let url = actor.profileURL {
                                        AsyncImage(url: url) { image in
                                            image.resizable()
                                        } placeholder: {
                                            Color.gray
                                        }
                                        .frame(width: 80, height: 120)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                    }
                                    Text(actor.name)
                                        .font(.caption)
                                        .frame(width: 80)
                                        .multilineTextAlignment(.center)
                                }
                            }
                        }
                    }
                }
            }
            .padding()
        }
        .onAppear {
            viewModel.fetchMovieDetails(movieId: movie.id)
        }
        .background(Color("PrimaryBackground"))
    }
}


struct YouTubeView: UIViewRepresentable {
    let videoID: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let url = URL(string: "https://www.youtube.com/embed/\(videoID)")!
        uiView.load(URLRequest(url: url))
    }
}

