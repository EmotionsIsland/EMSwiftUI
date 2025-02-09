import SwiftUI

struct MangaSingleGridView: View {
    @ObservedObject var viewModel: MangaListViewModel
    let mangaID: String  

    var body: some View {
        VStack(alignment: .leading) {
            if let manga = viewModel.getManga(by: mangaID) {
                AsyncImage(url: viewModel.getCoverURL(manga: manga, sizeFormat: .size256)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .scaledToFit()
                .frame(width: 100, height: 150)
                .cornerRadius(10)

                Text(manga.attributes.title.en ?? "")
                    .font(.headline)
                    .lineLimit(2)

                RatingView(rating: 4.0, maxRating: 5)

                Text(manga.type)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            } 
        }
        .frame(width: 120)
    }
}
