//
//  MangaSingleGridView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSingleGridView: View {
    
    var mangaData: MangaData
    var viewModel: MangaListViewModel
    
    var body: some View {
        VStack {
            AsyncImage(url: viewModel.getCoverURL(manga: mangaData, sizeFormat: .size256)) { image in
                switch image {
                case .empty:
                    RoundedRectangle(cornerRadius: 4)
                        .frame(width: 100, height: 144)
                        .foregroundStyle(.grayBase)
                case .success(let image):
                    image.resizedToFill(width: 100, height: 144)
                case .failure:
                    RoundedRectangle(cornerRadius: 4)
                        .frame(width: 100, height: 144)
                        .foregroundStyle(.grayBase)
                @unknown default:
                    EmptyView()
                        .frame(width: 100, height: 144)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 4))
            
            Text(mangaData.attributes.title.en ?? "Unknown")
                .frame(maxWidth: 100, alignment: .leading)
                .font(.custom(FontFamily.SFPro.semibold, size: 16))
            
            RatingView(
                rating: CGFloat.random(in: 0...5),
                maxRating: 5
            )
            
            Text(viewModel.getTagsArray(mangaData: mangaData).joined(separator: ", "))
                .frame(maxWidth: 100, alignment: .leading)
                .font(.custom(FontFamily.SFPro.light, size: 14))
                .foregroundStyle(.grayBase)
        }
        .frame(width: 100, height: 208)
    }
}

