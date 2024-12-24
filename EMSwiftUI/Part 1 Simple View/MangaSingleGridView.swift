//
//  MangaSingleGridView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSingleGridView: View {
    
    @EnvironmentObject var viewModel: MangaListViewModel
    let manga: MangaData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            mangaImageView
            
            mangaTitleView
            
            RatingView(rating: CGFloat(Double.random(in: 0...5)), maxRating: 5)
            
            mangaTagsView
        }
        .lineLimit(1)
    }
}

extension MangaSingleGridView {
    
    private var mangaImageView: some View {
        AsyncImage(url: MangaListViewModel().getCoverURL(
            manga: manga, sizeFormat: .size256)) { img in
            img
                .resizedToFill(width: 100, height: 144)
                .clipShape(RoundedRectangle(cornerRadius: 4))
                .padding(.bottom, 2)
        } placeholder: {
            ProgressView()
                .frame(width: 100, height: 144)
        }
    }
    
    private var mangaTitleView: some View {
        Text(manga.attributes.title.en ?? "No title")
            .font(.custom(FontFamily.SFProText.semibold, size: 16))
            .foregroundStyle(.blackBase)
    }
    
    private var mangaTagsView: some View {
        Text(viewModel.getTags(for: manga))
            .font(.custom(FontFamily.SFProText.thin, size: 14))
            .foregroundStyle(.grayBase)
    }
    
}
