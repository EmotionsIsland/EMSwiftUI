import SwiftUI

struct MangaSingleGridView: View {
    @ObservedObject var viewModel: MangaListViewModel
    let model: MangaData?
    
    var body: some View {
        VStack(alignment: .leading) {
            if let model = model {
                AsyncImage(url: viewModel.getCoverURL(manga: model, sizeFormat: .size512)) { img in
                    img
                        .resizedToFill(width: 100, height: 144)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                } placeholder: {
                    RoundedRectangle(cornerRadius: 4).frame(height: 144).animation(.easeInOut, value: 1)
                }
                .padding(.bottom, 4)
            }
            
            Text(model?.attributes.title.en ?? "No title").lineLimit(1).foregroundStyle(.blackBase)
            RatingView()
        }
    }
}
