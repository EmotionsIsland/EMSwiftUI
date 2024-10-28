//
//  MangaSingleGridView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSingleGridView: View {
    
    var mangaData: MangaData
    
    var mangaImageUrl: URL
    var mangaTags: [String]
    
    var body: some View {
        VStack(spacing: 4) {
            imageView
            footerView
        }
        .frame(width: 100, height: 208)
    }
}


private extension MangaSingleGridView {
    
    var imageView: some View {
        AsyncImage(url: mangaImageUrl) { image in
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
    }
    
    var footerView: some View {
        VStack(spacing: 2) {
            Text(mangaData.attributes.title.en ?? "Unknown")
                .frame(maxWidth: 100, alignment: .leading)
                .font(.custom(FontFamily.SFPro.semibold, size: 16))
            
            RatingView(
                rating: CGFloat.random(in: 0...5),
                maxRating: 5
            )
            
            Text(mangaTags.joined(separator: ", "))
                .frame(maxWidth: 100, alignment: .leading)
                .font(.custom(FontFamily.SFPro.light, size: 14))
                .foregroundStyle(.grayBase)
        }
    }
}
