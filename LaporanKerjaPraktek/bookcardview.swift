import SwiftUI

struct BookCardView: View {
    let book: Book

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            if let coverURL = getCoverURL(for: book) {
                AsyncImage(url: coverURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Color.gray.opacity(0.3)
                }
                .frame(width: 70, height: 100)
                .cornerRadius(8)
                .shadow(radius: 2)
            }

            VStack(alignment: .leading, spacing: 6) {
                Text(book.title)
                    .font(.headline)
                    .foregroundColor(.primary)

                if let authors = book.authors {
                    Text("📚 \(authors.joined(separator: ", "))")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

                if let year = book.year {
                    Text("📅 Terbit: \(year)")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            Spacer()
        }
        .padding()
        .background(.thinMaterial)
        .cornerRadius(12)
        .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 3)
    }

    func getCoverURL(for book: Book) -> URL? {
        if let coverID = book.coverID {
            return URL(string: "https://covers.openlibrary.org/b/id/\(coverID)-M.jpg")
        } else if let isbn = book.isbn?.first {
            return URL(string: "https://covers.openlibrary.org/b/isbn/\(isbn)-M.jpg")
        }
        return nil
    }
}
