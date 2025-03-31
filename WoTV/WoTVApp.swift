//
//  WoTVApp.swift
//  WoTV
//
//  Created by Vladyslav Markov on 27.03.2025.
//

import SwiftUI
import SwiftData

@main
struct WoTVApp: App {
    @State private var showLaunchScreen = true
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([FavoriteMovie.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Unable to initialize data storage: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            let favoritesViewModel = FavoritesViewModel(context: sharedModelContainer.mainContext)
            
            if showLaunchScreen {
                LaunchScreenView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                            showLaunchScreen = false
                        }
                    }
            } else {
                MainView()
                    .modelContainer(sharedModelContainer)
                    .environmentObject(favoritesViewModel)
            }
        }
    }
}
