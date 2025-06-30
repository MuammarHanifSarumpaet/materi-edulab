import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = BookViewModel()
    @StateObject private var favoritesVM = FavoritesViewModel()

    var body: some View {
        TabView {
            SearchView()
                .environmentObject(viewModel)
                .environmentObject(favoritesVM)
                .tabItem {
                    Label("Cari", systemImage: "magnifyingglass")
                }

            FavoritesView()
                .environmentObject(favoritesVM)
                .tabItem {
                    Label("Favorit", systemImage: "bookmark.fill")
                }
        }
    }
}
