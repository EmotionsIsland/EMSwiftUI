import SwiftUI

struct MangaSectionView<ViewModel: MangaListViewModel>: View {
    @ObservedObject var viewModel: ViewModel
    
    private let columns: [GridItem] = Array(
        repeating: GridItem(.fixed(100), spacing: 25),
        count: 3
    )
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 25, pinnedViews: .sectionHeaders) {
            ForEach(viewModel.filteredMangaList) { manga in
                MangaSingleGridView(viewModel: viewModel, item: manga)
            }
        }
        .padding(.horizontal)
    }
}
