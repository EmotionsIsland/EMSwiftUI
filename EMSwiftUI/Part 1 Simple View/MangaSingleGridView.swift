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
}

private extension MangaSingleGridView {
    var coverImageView: some View {
        AsyncImage(url: viewModel.getCoverURL(manga: data, sizeFormat: .size512)) { image in
            image
                .resizable()
                .frame(width: 100, height: 144)
                .clipShape(RoundedRectangle(cornerRadius: 4))
        } placeholder: {
            ZStack {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 100, height: 144)
                
                ProgressView()
            }
        }
    }
    
    var titleView: some View {
        Text(data.attributes.title.en ?? "No eng title")
            .lineLimit(1)
            .font(.custom(FontFamily.SFPro.bold, size: 16))
    }
    
    var tagsView: some View {
        Text(getTags())
            .lineLimit(1)
            .font(.custom(FontFamily.SFPro.light, size: 15))
            .foregroundStyle(.grayBase)
    }
    
    func getTags() -> String {
        let tagsName = data.attributes.tags.compactMap {
            $0.attributes.name.en
        }
        return tagsName.joined(separator: ", ")
    }
}

