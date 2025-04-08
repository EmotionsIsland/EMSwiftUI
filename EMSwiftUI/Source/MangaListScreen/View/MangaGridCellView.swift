//
//  MangaGridCellView.swift
//  EMSwiftUI
//
//  Created by Kirill Pukhov on 08.04.2025.
//

import Foundation
import SwiftUI

struct MangaGridCellView: View {
    let item: MangaListItem

    var body: some View {
        VStack(spacing: 4) {
            coverImage()

            mangaInfo()
        }
    }
}

private extension MangaGridCellView {
    func coverImage() -> some View {
        AsyncImage(url: item.coverURL) { image in
            image
                .resizable()
        } placeholder: {
            ProgressView()
                .progressViewStyle(.circular)
                .foregroundStyle(.secondary)
        }
        .aspectRatio(100 / 144, contentMode: .fit)
        .clipShape(RoundedRectangle(cornerRadius: 4))
    }

    func mangaInfo() -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(item.title)
                .lineLimit(1)
                .font(.SFPro.semiboldNormal)
                .foregroundStyle(.blackBase)

            RatingView(Double.random(in: 1...5))

            Text(item.genres.joined(separator: ", "))
                .lineLimit(1)
                .font(.SFPro.lightSmall)
                .foregroundStyle(.grayBase)
        }
    }
}
