import SwiftUI

// MARK: - Model
struct Book: Identifiable, Codable, Equatable {
    let id = UUID()
    let title: String
    let authors: [String]?
    let year: Int?
    let coverID: Int?
    let isbn: [String]?

    enum CodingKeys: String, CodingKey {
        case title
        case authors = "author_name"
        case year = "first_publish_year"
        case coverID = "cover_i"
        case isbn
    }

    // Equatable conformance
    static func == (lhs: Book, rhs: Book) -> Bool {
        lhs.title == rhs.title &&
        lhs.authors == rhs.authors &&
        lhs.year == rhs.year &&
        lhs.coverID == rhs.coverID &&
        lhs.isbn == rhs.isbn
    }
}

struct SearchResult: Codable {
    let docs: [Book]
}

// MARK: - ViewModel
class BookViewModel: ObservableObject {
    @Published var books: [Book] = []
    @Published var query: String = ""
    @Published var errorMessage: String? = nil

    func searchBooks() {
        guard !query.isEmpty else { return }
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlStr = "https://openlibrary.org/search.json?title=\(encodedQuery)&limit=10"

        guard let url = URL(string: urlStr) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    return
                }
                guard let data = data else {
                    self.errorMessage = "No data returned"
                    return
                }
                do {
                    let result = try JSONDecoder().decode(SearchResult.self, from: data)
                    self.books = result.docs
                    self.errorMessage = nil
                } catch {
                    self.errorMessage = error.localizedDescription
                }
            }
        }.resume()
    }
}

// MARK: - View
struct ContentView: View {
    @StateObject private var viewModel = BookViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.1), Color.white]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .edgesIgnoringSafeArea(.all)

                VStack(spacing: 16) {
                    // Search Field
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Cari judul buku...", text: $viewModel.query, onCommit: {
                            viewModel.searchBooks()
                        })
                        .textFieldStyle(PlainTextFieldStyle())
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
                    .padding()

                    // Error Message
                    if let error = viewModel.errorMessage {
                        Text("❌ \(error)")
                            .foregroundColor(.red)
                            .padding(.horizontal)
                    }

                    // Book List
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(viewModel.books) { book in
                                BookCardView(book: book)
                                    .transition(.slide)
                            }
                        }
                        .padding(.horizontal)
                        .animation(.easeInOut, value: viewModel.books)
                    }
                }
            }
            .navigationTitle("📘 Book Finder")
        }
    }
}

// MARK: - Book Card View
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
