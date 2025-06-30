import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var favoritesVM: favoritesViewModel

    var body: some View {
        NavigationView {
            List {
                if favoritesVM.favorites.isEmpty {
                    Text("Belum ada favorit")
                        .foregroundColor(.gray)
                } else {
                    ForEach(favoritesVM.favorites) { book in
                        NavigationLink(destination: BookDetailView(book: book)) {
                            BookCardView(book: book)
                        }
                    }
                    .onDelete(perform: favoritesVM.removeFavorite)
                }
            }
            .navigationTitle("❤️ Favorit")
            .toolbar {
                EditButton()
            }
        }
    }
}
