//
//  MangaSingleGridView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSingleGridView: View {
    
    let manga: CustomMangaModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            mangaImage
            mangaTitle
            RatingView(rating: 3.5, maxRating: 5)
            mangaTags
        }
    }
}

private extension MangaSingleGridView {
    
    var mangaImage: some View {
        AsyncImage(url: manga.imageURL) { phase in
            switch phase {
            case .empty:
                ShimmerEffectBox()
            case .success(let image):
                downloadedImage(image: image)
            case .failure:
                Image(systemName: "x.circle")
            @unknown default:
                EmptyView()
            }
        }
    }
    
    var mangaTitle: some View {
        Text(manga.title)
            .font(FontFamily.SFProText.medium.swiftUIFont(size: 16))
            .foregroundStyle(.blackBase)
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .lineLimit(1)
            .padding(.top, 2)
    }
    
    var mangaTags: some View {
        
        Text(manga.tags.joined(separator: ", "))
            .font(FontFamily.SFProText.light.swiftUIFont(size: 14))
            .foregroundStyle(.grayBase)
            .lineLimit(1)
            .frame(maxWidth: .infinity, alignment: .topLeading)
    }
    
    func downloadedImage(image: Image) -> some View {
        image
            .resizable()
            .aspectRatio(2/3, contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .clipped()
    }
    
    var noImage: some View {
        RoundedRectangle(cornerRadius: 12)
            .foregroundStyle(.grayBase)
            .aspectRatio(2/3, contentMode: .fit)
    }
}
