//
//  MangaSingleGridView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSingleGridView: View {
    @ObservedObject var viewModel: MangaListViewModel
    let data: MangaData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            coverImageView
            titleView
            RatingView(rating: 4.5, maxRating: 5)
            tagsView
        }
    }
    
    private var coverImageView: some View {
        let url = viewModel.getCoverURL(manga: data, sizeFormat: .size512)
        return AsyncImage(url: url) { image in
            image
                .resizable()
                .frame(width: 100, height: 144)
                .clipShape(RoundedRectangle(cornerRadius: 4))
        } placeholder: {
            ProgressView()
        }
    }
    
    private var titleView: some View {
        Text(data.attributes.title.en ?? "No eng title")
            .lineLimit(1)
            .font(.custom(FontFamily.SFPro.bold, size: 16))
    }
    
    private var tagsView: some View {
        let tagsName = data.attributes.tags.compactMap {
            $0.attributes.name.en
        }
        return Text(tagsName.joined(separator: ", "))
            .lineLimit(1)
            .font(.custom(FontFamily.SFPro.light, size: 15))
            .foregroundStyle(.grayBase)
    }
}


