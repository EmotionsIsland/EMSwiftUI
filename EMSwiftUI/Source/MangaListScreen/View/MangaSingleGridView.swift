//
//  MangaSingleGridView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSingleGridView: View {
    let model: MangaGridModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            dataToImage(model.image)
                .frame(height: 150)
            Text(model.title)
                .lineLimit(1)
                .font(Font.SFPro.semiboldNormal)
            RatingView(rating: CGFloat(model.rating),
                       maxRating: model.maxRating)
            Text(model.tag)
                .font(Font.SFPro.lightSmall)
                .lineLimit(1)
                .foregroundStyle(
                    Color.grayBase
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
    MangaSingleGridView(model: MangaGridModel(image: Data(),
                        title: "Spy X Family",
                        rating: 4.5,
                        maxRating: 5,
                        tag: "Award winning"))
}
