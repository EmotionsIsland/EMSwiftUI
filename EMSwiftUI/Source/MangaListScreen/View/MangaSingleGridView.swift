//
//  MangaSingleGridView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSingleGridView: View {
    let item: MangaItem

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            coverImage

            Text(item.title)
                .font(.SFPro.semiboldNormal)
                .foregroundStyle(.blackBase)
                .lineLimit(1)

            RatingView(rating: item.rating, maxRating: 5)

            Text(item.genres)
                .font(.SFPro.lightSmall)
                .foregroundStyle(.grayBase)
                .lineLimit(1)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    @ViewBuilder
    private var coverImage: some View {
        AsyncImage(url: item.coverURL) { phase in
            switch phase {
            case .empty:
                placeholder

            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()

            case .failure:
                placeholder

            @unknown default:
                placeholder
            }
        }
        .frame(height: 120)
        .frame(maxWidth: .infinity)
        .clipped()
        .clipShape(RoundedRectangle(cornerRadius: 4))
    }

    private var placeholder: some View {
        RoundedRectangle(cornerRadius: 4)
            .fill(.grayBase.opacity(0.2))
    }
}
