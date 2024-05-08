import SwiftUI

struct MangaSectionView: View {
    @ObservedObject var viewModel: MangaListViewModel
    @State var sectionTitle: String = ""
    
    private let columns = [GridItem(.flexible(), spacing: 25), GridItem(.flexible(), spacing: 25), GridItem(.flexible(), spacing: 25)]
    
    var body: some View {
        VStack(spacing: 0) {
            MangaSectionTitleView(title: $sectionTitle)
                .padding(.bottom, 16)
            
            LazyVGrid(columns: columns) {
                if let mangaList = viewModel.mangaList {
                    ForEach(mangaList.data, id: \.id) { man in
                        MangaSingleGridView(viewModel: viewModel, model: man)
                    }
                } 
            }
        }.padding(.horizontal, 8)
    }
}

