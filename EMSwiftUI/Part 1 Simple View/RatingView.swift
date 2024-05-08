import SwiftUI

struct RatingView: View {
    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<Int.random(in: 1..<6), id: \.self) { _ in
                Image(.starIcon).foregroundStyle(.yellow)
            }
        }
    }
}

