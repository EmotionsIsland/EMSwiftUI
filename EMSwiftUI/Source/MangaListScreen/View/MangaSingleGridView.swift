//
//  MangaSingleGridView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSingleGridView: View {
    let model: MangaData
    let urlForImage: URL?

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            MangaCoverImage(urlForImage: urlForImage)
                .padding(.bottom, 2)

            titleText
            RatingView(rating: CGFloat.random(in: 1...5), maxRating: 5)
            tagsText
        }
        .frame(width: 100)
    }
}

private extension MangaSingleGridView {
    var titleText: some View {
        Text(model.attributes.title.en ?? "No title")
            .foregroundStyle(Color.blackBase)
            .font(Font.SFPro.semiboldNormal)
            .lineLimit(1)
    }

    var tagsText: some View {
        let tagsText = model.attributes.tags
            .compactMap { $0.attributes.name.en }
            .joined(separator: ", ")
        return Text(tagsText)
            .foregroundStyle(Color.grayBase)
            .font(Font.SFPro.lightSmall)
            .lineLimit(1)
    }
}
