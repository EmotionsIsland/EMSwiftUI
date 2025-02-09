import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = MangaListViewModel(service: MangaListService(network: Network()))
    @State private var isSearching = false
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: FilterView(), isActive: $isSearching) {
                    EmptyView()
                }
                .hidden()

                SearchBar(isSearching: $isSearching)

                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        ForEach(viewModel.mangaData) { manga in
                            MangaSectionView(viewModel: viewModel, title: manga.attributes.tags.first?.attributes.name.en ?? "")
                        }
                    }
                }
                .ignoresSafeArea(edges: .bottom)
            }
            .navigationBarHidden(true)
            .onAppear {
                viewModel.fetchManga()
            }
        }
    }
}


