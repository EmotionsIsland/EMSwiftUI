//
//  MangaSingleGridView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSingleGridView: View {
    let image: Data
    let title: String
    let rating: Float
    let maxRating: Int
    let tag: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            dataToImage(image)
                .frame(height: 150)
            Text(title)
                .lineLimit(1)
                .font(Font.SFPro.semiboldNormal)
            RatingView(rating: CGFloat(rating),
                       maxRating: maxRating)
            Text(tag)
                .font(Font.SFPro.lightSmall)
                .lineLimit(1)
                .foregroundStyle(
                    Color.init(
                        cgColor: #colorLiteral(red: 0.8110429645, green: 0.8110429049, blue: 0.8110429049, alpha: 1))
                )
        }
        .frame(width: 100)
    }
    
    // MARK: dataToImage
    private func dataToImage(_ data: Data?) -> some View {
        if let data = data, let uiImage = UIImage(data: data) {
            return AnyView(Image(uiImage: uiImage)
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: 4))
            )
        } else {
            return AnyView(
                Rectangle()
                .fill(Color.gray.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            )
        }
    }
}

#Preview {
    MangaSingleGridView(image: Data(),
                        title: "Spy X Family",
                        rating: 4.5,
                        maxRating: 5,
                        tag: "Award winning")
}
