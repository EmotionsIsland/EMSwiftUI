//
//  MangaGridItemView.swift
//  EMSwiftUI
//
//  Created by Денис Ефименков on 06.02.2026.
//
import SwiftUI

struct MangaGridItemView: View {
    let model: MangaUIModel

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Image(model.coverName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 150)
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .clipped()

            Text(model.title)
                .font(.subheadline)
                .fontWeight(.semibold)
                .lineLimit(1)

            RatingView(rating: model.rating, maxRating: 5)

            Text(model.subtitle)
                .font(.caption)
                .foregroundStyle(.secondary)
                .lineLimit(1)
        }
    }
}
