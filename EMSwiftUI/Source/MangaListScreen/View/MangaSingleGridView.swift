//
//  MangaSingleGridView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSingleGridView: View {
    let model: MangaViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
//            AsyncImage(url: model.coverUrl) { image in
//                image
//                    .resizable()
//            } placeholder: {
//                ShimmerView(view: Color.grayBase)
//            }
//            .aspectRatio(100 / 144, contentMode: .fill)
//            .clipShape(.rect(cornerRadius: 4))
            MangaCoverView(url: model.coverUrl)

            VStack(alignment: .leading, spacing: 2) {
                Text(model.title)
                    .font(.SFPro.semiboldNormal)
                    .foregroundStyle(Color(.blackBase))
                    .lineLimit(1)
                RatingView(rating: model.rating)
                Text(model.tags)
                    .font(.SFPro.lightSmall)
                    .foregroundStyle(Color.grayBase)
                    .lineLimit(1)
            }
        }
    }
}
