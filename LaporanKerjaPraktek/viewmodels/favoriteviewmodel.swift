import Foundation

class FavoritesViewModel: ObservableObject {
    @Published private(set) var favorites: [Book] = []

    func toggleFavorite(_ book: Book) {
        if let index = favorites.firstIndex(of: book) {
            favorites.remove(at: index)
        } else {
            favorites.append(book)
        }
    }

    func isFavorite(_ book: Book) -> Bool {
        favorites.contains(book)
    }

    func removeFavorite(atOffsets offsets: IndexSet) {
        favorites.remove(atOffsets: offsets)
    }
}
