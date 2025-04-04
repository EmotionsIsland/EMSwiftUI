import SwiftUI

struct MangaSingleGridView<ViewModel: MangaListViewModel>: View {
    @ObservedObject var viewModel: ViewModel
    let item: MangaListItem
    private let maxRaiting = 5

    var body: some View {
        VStack(spacing: 4) {
            MangaCoverImage(coverURL: item.coverURL)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(item.title)
                    .font(Font.SFPro.semiboldNormal)
                    .lineLimit(1)
                    .foregroundStyle(.blackBase)
                
                RatingView(rating: CGFloat.random(in: 1...5), maxRating: maxRaiting)
                
                Text(item.genres.joined(separator: ", "))
                    .font(Font.SFPro.lightSmall)
                    .lineLimit(1)
                    .foregroundStyle(.grayBase)
            }
        }
    }
}
