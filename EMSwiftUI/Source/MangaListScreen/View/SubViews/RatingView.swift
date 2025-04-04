import SwiftUI

struct RatingView: View {
    let rating: CGFloat
    let maxRating: Int
    
    init(rating: CGFloat, maxRating: Int = 5) {
        self.rating = rating
        self.maxRating = maxRating
    }
    
    var body: some View {
        VStack {
            stars
                .overlay {
                    GeometryReader { item in
                        let width = rating / CGFloat(maxRating) * item.size.width
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .frame(width: width)
                                .foregroundStyle(Color.yellow)
                        }
                    }
                    .mask(stars)
                }
                .foregroundStyle(Color.gray)
        }
    }
    
    private var stars: some View {
        HStack {
            ForEach(0..<maxRating, id: \.self) { _ in
                Image(.starIcon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
    }
}

#Preview {
    RatingView(rating: 4.3)
        .frame(width: 100)
}
