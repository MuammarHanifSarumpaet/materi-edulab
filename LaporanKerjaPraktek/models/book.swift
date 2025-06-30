import Foundation

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
