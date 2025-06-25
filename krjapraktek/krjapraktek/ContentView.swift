import SwiftUI
import AVFoundation

struct ContentView: View {
    @State private var searchText = ""
    @State private var tracks: [Track] = []
    @State private var player: AVPlayer?

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Search artist", text: $searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)

                    Button("Search") {
                        fetchTracks()
                    }
                    .padding(.trailing)
                }

                List(tracks) { track in
                    VStack(alignment: .leading) {
                        HStack {
                            AsyncImage(url: URL(string: track.album.coverSmall)) { image in
                                image.resizable()
                            } placeholder: {
                                Color.gray
                            }
                            .frame(width: 50, height: 50)
                            .cornerRadius(6)

                            VStack(alignment: .leading) {
                                Text(track.title)
                                    .font(.headline)
                                Text(track.album.title)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            Button(action: {
                                playPreview(url: track.preview)
                            }) {
                                Image(systemName: "play.circle.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                            }
                        }
                    }
                    .padding(.vertical, 5)
                }
            }
            .navigationTitle("musik hanip 🎵")
            .onAppear {
                fetchTracks()
            }
        }
    }

    func fetchTracks() {
        DeezerAPI.searchTracks(query: searchText) { result in
            self.tracks = result
        }
    }

    func playPreview(url: String) {
        guard let previewURL = URL(string: url) else { return }
        player = AVPlayer(url: previewURL)
        player?.play()
    }
}
