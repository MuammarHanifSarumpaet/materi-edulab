import SwiftUI

struct SearchView: View {
    @EnvironmentObject var viewModel: BookViewModel
    @EnvironmentObject var favoritesVM: FavoritesViewModel

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

                    if let error = viewModel.errorMessage {
                        Text("❌ \(error)")
                            .foregroundColor(.red)
                            .padding(.horizontal)
                    }

                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(viewModel.books) { book in
                                NavigationLink(destination: BookDetailView(book: book)) {
                                    BookCardView(book: book)
                                }
                                .buttonStyle(PlainButtonStyle())
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
