import Foundation

struct DeezerResponse: Codable {
    let data: [Track]
}

struct Track: Codable, Identifiable {
    let id: Int
    let title: String
    let preview: String
    let album: Album
}

struct Album: Codable {
    let title: String
    let coverSmall: String

    enum CodingKeys: String, CodingKey {
        case title
        case coverSmall = "cover_small"
    }
}
