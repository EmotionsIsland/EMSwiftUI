//
//  MangaSingleGridView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSingleGridView: View {
    let mangaList: [MangaData]
    
    let columns: [GridItem] = Array(
        repeating: .init(.flexible(), spacing: 25), count: 3)
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 25) {
            ForEach(mangaList) { manga in
                MangaGridItemView(manga: manga)
            }
        }
    }
}

struct MangaGridItemView: View {
    let manga: MangaData
    
    var body: some View {
        VStack(spacing: 0) {
            AsyncImage(
                url: MangaListViewModel().getCoverURL(
                    manga: manga, sizeFormat: .size256)
            ) { image in
                image.resizable()
                    .scaledToFill()
                    .frame(maxWidth: 100, maxHeight: 144)
                    .clipped()
                    .cornerRadius(4)
            } placeholder: {
                ProgressView()
            }
            
            Text(manga.attributes.title.en ?? "Unknown Title")
                .font(FontFamily.SFPro.semibold.swiftUIFont(size: 16))
                .lineLimit(1)
            
            RatingView(rating: CGFloat(Int.random(in: 0..<5)), maxRating: 5)
            
            Text(
                manga.attributes.tags
                    .compactMap { $0.attributes.name.en }
                    .joined(separator: ", "))
            .font(FontFamily.SFPro.light.swiftUIFont(size: 14))
            .foregroundColor(Asset.Colors.grayBase.swiftUIColor)
            .lineLimit(1)
        }
    }
}

//#Preview {
//    MangaSingleGridView()
//}
