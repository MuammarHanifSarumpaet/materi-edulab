import SwiftUI

struct BookDetailView: View {
    let book: Book
    @EnvironmentObject var favoritesVM: FavoritesViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let coverURL = getCoverURL(for: book) {
                    AsyncImage(url: coverURL) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        Color.gray.opacity(0.2)
                    }
                    .frame(height: 300)
                    .cornerRadius(12)
                }

                Text(book.title)
                    .font(.title)
                    .bold()

                if let authors = book.authors {
                    Text("📚 Ditulis oleh: \(authors.joined(separator: ", "))")
                        .font(.body)
                }

                if let year = book.year {
                    Text("📅 Tahun Terbit: \(year)")
                        .font(.body)
                }

                if let isbn = book.isbn {
                    Text("🔢 ISBN: \(isbn.joined(separator: ", "))")
                        .font(.body)
                }

                Button(action: {
                    favoritesVM.toggleFavorite(book)
                }) {
                    Label(
                        favoritesVM.isFavorite(book) ? "Hapus dari Favorit" : "Tambah ke Favorit",
                        systemImage: favoritesVM.isFavorite(book) ? "bookmark.fill" : "bookmark"
                    )
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }

                Spacer()
            }
            .padding()
        }
        .navigationTitle("📖 Detail Buku")
        .navigationBarTitleDisplayMode(.inline)
    }

    func getCoverURL(for book: Book) -> URL? {
        if let coverID = book.coverID {
            return URL(string: "https://covers.openlibrary.org/b/id/\(coverID)-L.jpg")
        } else if let isbn = book.isbn?.first {
            return URL(string: "https://covers.openlibrary.org/b/isbn/\(isbn)-L.jpg")
        }
        return nil
    }
}
