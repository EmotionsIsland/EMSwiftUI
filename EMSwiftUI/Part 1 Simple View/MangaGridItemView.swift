//
//  MangaGridItemView.swift
//  EMSwiftUI
//
//  Created by Иван Незговоров on 18.12.2024.
//
import SwiftUI

struct MangaGridItemView: View {
    let manga: MangaData
    
    var body: some View {
        mainView
    }
}

private extension MangaGridItemView {
    var mainView: some View {
        VStack(spacing: 0) {
            AsyncImage(
                url: MangaListViewModel().getCoverURL(
                    manga: manga, sizeFormat: .size256)
            ) { image in
                image.resizable()
                    .scaledToFill()
                    
                    .clipped()
                    .cornerRadius(4)
            } placeholder: {
                ProgressView()
            }
            .frame(maxWidth: 100, maxHeight: 144)
            
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
