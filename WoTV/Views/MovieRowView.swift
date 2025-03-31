//
//  MovieRowView.swift
//  WoTV
//
//  Created by Vladyslav Markov on 27.03.2025.
//

import SwiftUI

struct MovieRowView: View {
    let movie: Movie
    
    var body: some View {
        HStack {
            AsyncImage(url: movie.posterURL) { image in
                image.resizable()
            } placeholder: {
                Color.gray.opacity(0.3)
            }
            .frame(width: 80, height: 120)
            .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(movie.title)
                    .font(.title2)
                
                Text(movie.releaseDate ?? "Unknown date")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundStyle(.yellow)
                    Text("\(String(format: "%.1f", movie.voteAverage))")
                        .font(.subheadline)
                        .bold()
                }
    
            }
            .padding(.leading, 8)
            
            Spacer()
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    MovieRowView(movie: Movie(id: 1, title: "Inception", overview: "Cool", posterPath: "/qJ2tW6WMUDux911r6m7haRef0WH.jpg", releaseDate: "2010-07-16", voteAverage: 8.8))
}
