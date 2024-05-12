import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = MangaListViewModel(service: MangaListService(network: Network()))
    @State private var searchString = ""
    @FocusState private var isFocused: Bool
    let sectionTitles = ["Popular", "Recently Added", "Last updates", "Seasonal"]
    
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
                    ForEach(sectionTitles, id: \.self) { title in
                        MangaSectionView(viewModel: viewModel, sectionTitle: title)
                    }
                }
                .onTapGesture {
                    isFocused = false
                }
            }
        }
        .focused($isFocused)
    }
}
