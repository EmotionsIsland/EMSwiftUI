import SwiftUI

struct MangaSectionView: View {
    @ObservedObject var viewModel: MangaListViewModel
    let title: String
    let rows = Array(repeating: GridItem(.fixed(200), spacing: 25), count: 2)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            MangaSectionTitleView(title: title)

            LazyHGrid(rows: rows, spacing: 25) {
                ForEach(viewModel.mangaData) { manga in
                    MangaSingleGridView(viewModel: viewModel, mangaID: manga.id)
                        .frame(width: 100, height: 200)
                }
            }
        }
        .padding(.horizontal)
    }
}
