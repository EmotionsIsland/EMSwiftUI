import SwiftUI

struct MangaSingleGridView: View {
    var imageURL: URL?
    var title: String
    var rating: Double
    var genres: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            AsyncImage(url: imageURL ?? URL(string: "https://via.placeholder.com/300x450.png?text=No+Image")) { phase in
                switch phase {
                case .empty:
                        ProgressView()
                            .frame(maxWidth: .infinity)
                            .aspectRatio(0.7, contentMode: .fit)
                case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(0.7, contentMode: .fit)
                            .cornerRadius(8)
                case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                            .aspectRatio(0.7, contentMode: .fit)
                            .foregroundColor(.gray)
                @unknown default:
                        EmptyView()
                }
            }
            
            Text(title)
                .font(.headline)
                .lineLimit(1)
                .foregroundColor(.primary)
            
            RatingView(rating: 4.3)
            
            Text(genres)
                .font(.subheadline)
                .foregroundColor(.gray)
                .lineLimit(1)
                .truncationMode(.tail)
        }
        .frame(width: 100)
        }
}
