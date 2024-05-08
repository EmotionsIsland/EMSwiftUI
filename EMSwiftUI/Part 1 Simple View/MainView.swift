import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = MangaListViewModel(service: MangaListService(network: Network()))
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 8).frame(height: 36).padding(.horizontal, 16).foregroundStyle(.grayBase.opacity(0.4)).overlay {
                HStack(spacing: 4) {
                    Image(systemName: "magnifyingglass").foregroundStyle(.gray)
                    Text("Search").foregroundStyle(.gray)
                    Spacer()
                }.padding(.horizontal, 24)
            }
            Rectangle().frame(height: 1).foregroundStyle(.grayBase)
            
        }.padding(.vertical, 8)
        
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack {
                MangaSectionView(viewModel: viewModel, sectionTitle: "Popular")
                    MangaSectionView(viewModel: viewModel, sectionTitle: "Recently added")
                    MangaSectionView(viewModel: viewModel, sectionTitle: "Last updates")
                    MangaSectionView(viewModel: viewModel, sectionTitle: "Seasonal")
            }
        }.padding(.horizontal, 10)
    }
}
