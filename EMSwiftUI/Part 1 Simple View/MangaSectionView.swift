//
//  MangaSectionView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSectionView: View {
    @EnvironmentObject var viewModel: MangaListViewModel
    
    let item: MangaData
    
    var body: some View {
        VStack(spacing: 4) {
            AsyncImage(url: viewModel.getCoverURL(manga: item, sizeFormat: .size256)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 100, height: 144)
            
            titleView
                .frame(width: 100)
        }
    }
}

private extension MangaSectionView {
    var titleView: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(item.attributes.title.en ?? "Unknown Title")
                .font(.custom(FontFamily.SFPro.bold, size: 16))
                .foregroundStyle(.blackBase)
            RatingView(rating: 4.5, maxRating: 5)
            Text(item.attributes.tags.map { $0.attributes.name.en ?? "" }.joined(separator: ", "))
                .font(.custom(FontFamily.SFPro.condensedLight, size: 16))
                .foregroundStyle(.grayBase)
        }
    }
}
