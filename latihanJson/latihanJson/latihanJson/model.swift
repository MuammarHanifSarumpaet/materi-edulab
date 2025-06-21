// model.swift
import Foundation
import Alamofire
import SwiftyJSON

// Model untuk berita
struct NewsItem: Identifiable, Codable {
    var id: Int
    let headline: String
    let abstract: String
    let body: String
    let author: String
    let section: String
    let date: String
    let article_uri: String
    let pfd_uri: String
    let monitoredSecondaryCapacity: String  // Data tambahan untuk monitored secondary capacity
}

// Class untuk mengambil berita dari API
class NewsFetcher: ObservableObject {
    @Published var news: [NewsItem] = []  // Menyimpan daftar berita

    // Fungsi untuk mengambil berita dari API
    func fetchNews() {
        let url = "https://fakenews.squirro.com/news/technology" // URL API yang diambil
        
        // Menggunakan Alamofire untuk mengambil data
        AF.request(url).responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let newsArray = json["news"].arrayValue
                var loadedNews: [NewsItem] = []

                // Parsing data JSON ke dalam array NewsItem
                for item in newsArray {
                    let newsItem = NewsItem(
                        id: item["id"].intValue,
                        headline: item["headline"].stringValue,
                        abstract: item["abstract"].stringValue,
                        body: item["body"].stringValue,
                        author: item["author"].stringValue,
                        section: item["section"].stringValue,
                        date: item["date"].stringValue,
                        article_uri: item["article_uri"].stringValue,
                        pfd_uri: item["pfd_uri"].stringValue,
                        monitoredSecondaryCapacity: item["monitored_secondary_capacity"].stringValue // Tambahkan field baru
                    )
                    loadedNews.append(newsItem)
                }

                DispatchQueue.main.async {
                    self.news = loadedNews // Update data berita di UI
                }

            case .failure(let error):
                print("Error fetching news: \(error)") // Error handling
            }
        }
    }
}
