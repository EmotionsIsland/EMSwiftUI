import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = MangaListViewModel(service: MangaListService(network: Network()))
    @State private var searchString = ""
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack {
            VStack(spacing: 8) {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .frame(height: 36)
                        .padding(.horizontal, 16)
                        .foregroundStyle(.grayBase.opacity(0.4))
                        .overlay {
                            HStack(spacing: 4) {
                                if searchString == "" && !isFocused {
                                Image(systemName: "magnifyingglass")
                                    .foregroundStyle(.grayBase)
                                    
                                    Text("Search")
                                        .foregroundStyle(.grayBase)
                                }
                                Spacer()
                            }
                            .padding(.horizontal, 24)
                        }
                    TextField("", text: $searchString)
                        .padding(.horizontal, 24)
                }
                .padding(.top, 6)
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(.grayBase)
            }
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    MangaSectionView(viewModel: viewModel, sectionTitle: "Popular")
                    MangaSectionView(viewModel: viewModel, sectionTitle: "Recently added")
                    MangaSectionView(viewModel: viewModel, sectionTitle: "Last updates")
                    MangaSectionView(viewModel: viewModel, sectionTitle: "Seasonal")
                }
                .onTapGesture {
                    isFocused = false
                    
                }
                
            }
        }
        .focused($isFocused)
    }
}
