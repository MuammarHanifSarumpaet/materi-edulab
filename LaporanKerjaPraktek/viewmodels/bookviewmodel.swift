import Foundation

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
