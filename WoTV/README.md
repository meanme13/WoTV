# WoTV

WoTV is a mobile application for browsing information about movies and TV shows, built using SwiftUI and SwiftData. It allows users to search for movies, view details, save favorites, and filter by genres.

## 📌 Features
- Display a list of popular movies
- Filter movies by genres
- View detailed movie information (poster, description, rating, trailer, actors)
- Add movies to favorites
- Generate 10 random movies
- Light and dark mode (automatic switching based on system settings)
- Splash screen on app launch

## 🛠️ Technologies Used
- **SwiftUI** — Declarative UI framework
- **SwiftData** — Local data management (favorites)
- **Combine** — Reactive programming and state management
- **URLSession** — Handling HTTP requests
- **TMDb API** — Fetching movie data

## 📂 Project Architecture
The project follows the MVVM (Model-View-ViewModel) pattern:
- **Models/** — Data structures (Movie, Genre, Actor, FavoriteMovie)
- **ViewModels/** — Presentation logic (MovieListViewModel, MovieDetailViewModel, FavoritesViewModel)
- **Views/** — UI components (MovieListView, MovieDetailView, FavoritesView, etc.)
- **Storage/** — Local data management

## 📦 Installation
1. Clone the repository:

   ```bash
   git clone https://github.com/yourusername/WoTV.git
   cd WoTV
   ```
2. Open the project in Xcode.
3. Make sure you have Swift 5.9+ and Xcode 15+ installed.
4. Run the project on a simulator or real device.

## 🔗 API Key
To use the TMDb API, you need to obtain an API key:
1. Register at [TMDb](https://www.themoviedb.org/)
2. Generate an API key in your account settings
3. Add the key to `Constants.swift`:

   ```swift
   struct Constants {
       static let apiKey = "YOUR_API_KEY"
   }
   ```

## 🔧 Future Improvements
- UI/UX enhancements
- Localization support
- Trailer playback support

## 📜 License
This project is licensed under the MIT License.

