//
//  MangaSingleGridView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSingleGridView: View {
    let manga: MangaModel

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Color.clear
                .aspectRatio(100/144, contentMode: .fit)
                .overlay(
                    AsyncImage(url: manga.coverUrl) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        Color.gray
                    }
                )
                .clipShape(RoundedRectangle(cornerRadius: 4))
                .padding(.bottom, 2)
            Text(manga.title)
                .font(.SFPro.semiboldNormal)
                .lineLimit(1)
            RatingView(rating: manga.rating)
                .padding(.bottom, 4)
            Text(manga.genres.joined(separator: ", "))
                .font(.SFPro.lightSmall)
                .foregroundStyle(.grayBase)
                .lineLimit(1)
        }
    }
}
