import Foundation

class DeezerAPI {
    static func searchTracks(query: String, completion: @escaping ([Track]) -> Void) {
        let searchQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        guard let url = URL(string: "https://api.deezer.com/search?q=\(searchQuery)") else {
            completion([])
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completion([])
                return
            }

            do {
                let result = try JSONDecoder().decode(DeezerResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(result.data)
                }
            } catch {
                print("Decoding error:", error)
                DispatchQueue.main.async {
                    completion([])
                }
            }
        }.resume()
    }
}
