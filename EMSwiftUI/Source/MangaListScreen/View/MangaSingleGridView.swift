//
//  MangaSingleGridView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSingleGridView: View {
    private let model: MangaData
    private let urlForImage: URL?

    init(model: MangaData, urlForImage: URL?) {
        self.model = model
        self.urlForImage = urlForImage
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            coverImage
            .padding(.bottom, 2)

            titleText
            RatingView(rating: CGFloat.random(in: 1...5), maxRating: 5)
            tagsText
        }
        .frame(width: 100)
    }
}

private extension MangaSingleGridView {
    var coverImage: some View {
        AsyncImage(url: urlForImage) { phase in
            switch phase {
            case .empty:
                ZStack {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.whiteText)
                    ProgressView()
                }
                    .frame(width: 100, height: 144)
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 144)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
            case .failure:
                Color.gray
                    .frame(width: 100, height: 144)
                    .overlay(Text("Error").foregroundColor(.white))
            @unknown default:
                EmptyView()
            }
        }
    }

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
