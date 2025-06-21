// ContentView.swift
import SwiftUI

struct ContentView: View {
    @StateObject private var newsFetcher = NewsFetcher()  // Menggunakan @StateObject untuk observasi data berita
    
    var body: some View {
        NavigationView {
            List(newsFetcher.news) { item in
                // Navigasi ke halaman detail saat item dipilih
                NavigationLink(destination: NewsDetailView(newsItem: item)) {
                    VStack(alignment: .leading) {
                        Text(item.headline)
                            .font(.headline) // Menampilkan headline berita

                        Text(item.author)
                            .font(.subheadline)
                            .foregroundColor(.secondary) // Menampilkan penulis berita
                    }
                    .padding() // Memberikan padding untuk tata letak
                }
            }
            .navigationTitle("Tech News") // Judul di bagian atas halaman
        }
        .onAppear {
            newsFetcher.fetchNews() // Memuat berita saat tampilan muncul
        }
    }
}

#Preview {
    ContentView() // Pratinjau tampilan
}
