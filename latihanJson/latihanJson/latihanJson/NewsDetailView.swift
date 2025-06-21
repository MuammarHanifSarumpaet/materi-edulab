// NewsDetailView.swift
import SwiftUI

// Tampilan detail berita
struct NewsDetailView: View {
    var newsItem: NewsItem  // Menerima data berita yang dipilih

    var body: some View {
        ScrollView { // Menggunakan ScrollView agar konten bisa digulir
            VStack(alignment: .leading, spacing: 16) {
                // Menampilkan judul berita
                Text(newsItem.headline)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 10)

                // Menampilkan penulis berita
                Text("By \(newsItem.author)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                // Menampilkan tanggal berita
                Text(newsItem.date)
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 15)

                // Menampilkan informasi tambahan (monitoredSecondaryCapacity)
                Text("Monitored Secondary Capacity: \(newsItem.monitoredSecondaryCapacity)")
                    .font(.body)
                    .padding(.bottom, 15)

                Divider() // Pembatas visual

                // Menampilkan body artikel
                Text(newsItem.body)
                    .font(.body)
                    .padding(.bottom, 20)

                // Jika ada link ke artikel lengkap
                if let url = URL(string: newsItem.article_uri) {
                    Link("Read Full Article", destination: url)
                        .padding(.top)
                        .foregroundColor(.blue)
                }
            }
            .padding()
        }
        .navigationTitle("News Detail") // Menampilkan judul halaman
        .navigationBarTitleDisplayMode(.inline) // Menampilkan judul dalam mode inline
    }
}

struct NewsDetailView_Previews: PreviewProvider {
    static var previews: some View {
        // Preview untuk NewsDetailView dengan data dummy
        NewsDetailView(newsItem: NewsItem(id: 1, headline: "Test News", abstract: "Abstract", body: "This is the body.", author: "Author", section: "Tech", date: "2025-04-16", article_uri: "https://example.com", pfd_uri: "https://example.com", monitoredSecondaryCapacity: "100 GB"))
    }
}
