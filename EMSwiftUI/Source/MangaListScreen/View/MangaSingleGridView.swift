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
        VStack {
            AsyncImage(url: model.imageUrl) { image in
                image
                .resizedToFill(width: 100, height: 144)
                .clipShape(RoundedRectangle(cornerRadius: 4))
                .padding(4)
            } placeholder: {
                Color.gray
                .frame(width: 120, height: 144)
            }
            Text(model.title)
                .font(Font.SFPro.semiboldNormal)
                .lineLimit(1)
                .padding(.bottom, 2)
                .frame(width: 120)
            RatingView(rating: model.rating)
            Text(model.tags)
                .foregroundStyle(.grayBase)
                .font(Font.SFPro.lightSmall)
                .lineLimit(1)
        }
    }
}
#Preview {
    MangaSingleGridView(model: .init(title: "manga title", tags: "tags"))
}
