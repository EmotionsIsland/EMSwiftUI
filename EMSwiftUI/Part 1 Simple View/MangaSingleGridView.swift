import SwiftUI

struct MangaSingleGridView: View {
    @ObservedObject var viewModel: MangaListViewModel
    let model: MangaData?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            if let model = model {
                AsyncImage(url: viewModel.getCoverURL(manga: model, sizeFormat: .size512)) { img in
                    img
                        .resizedToFill(width: 100, height: 144)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                } placeholder: {
                    RoundedRectangle(cornerRadius: 4)
                        .frame(height: 144)
                        .animation(.easeInOut, value: 1)
                }
            }
            
            Text(model?.attributes.title.en ?? "No title")
                .lineLimit(1)
                .foregroundStyle(.blackBase)
            Text(["Comedy", "Action", "Fantasy", "Drama"].randomElement()!)
                .lineLimit(1)
                .foregroundStyle(.grayBase)
                .font(.system(size: 14))
            RatingView()
        }
    }
}
