import SwiftUI

struct RatingView: View {
    let rating: Double
    let maxRating: Int = 5

    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<maxRating, id: \.self) { index in
                starView(for: index)
                    .frame(width: 17, height: 16)
            }
        }
    }
}

private extension RatingView {
    func starView(for index: Int) -> some View {
        let fillLevel = min(max(rating - Double(index), 0), 1)
        
        return ZStack {
            Image(systemName: "star")
                .foregroundColor(.gray.opacity(0.3))

            if fillLevel > 0 {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                    .overlay(
                        GeometryReader { geometry in
                            Rectangle()
                                .fill(Color.grayBase)
                                .frame(width: geometry.size.width * (1 - fillLevel))
                                .offset(x: geometry.size.width * fillLevel)
                        }
                        .mask(
                            Image(systemName: "star.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        )
                    )
            }
        }
    }
}
