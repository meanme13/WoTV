//
//  MainView.swift
//  WoTV
//
//  Created by Vladyslav Markov on 29.03.2025.
//

import SwiftUI
import SwiftData

struct MainView: View {
    var body: some View {
        TabView {
            MovieListView()
                .tabItem {
                    Label("Popular", systemImage: "film.fill")
                }

            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }

            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "star.fill")
                }
        }
    }
}
