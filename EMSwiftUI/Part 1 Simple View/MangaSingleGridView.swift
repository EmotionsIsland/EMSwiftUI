//
//  MangaSingleGridView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSingleGridView: View {
    let mangas: [MangaData]
    var coverURL: (MangaData) -> URL
    let columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 25), count: 3)
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 25) {
            ForEach(mangas) { manga in
                MangaGridItemView(manga: manga, coverURL: coverURL)
            }
        }
    }
}


struct MangaGridItemView: View {
    let manga: MangaData
    var coverURL: (MangaData) -> URL
    
    var body: some View {
        VStack {
            AsyncImage(url: coverURL(manga)) { image in
                image.resizable()
                
            } placeholder: {
                ProgressView()
            }
            .frame(width: 100, height: 144)
            .cornerRadius(4)
            .padding(.bottom, 4)
            
            Text(manga.attributes.title.en ?? "No eng title")
                .font(FontFamily.SFProText.semibold.swiftUIFont(size: 16))
                .lineLimit(1)
                .padding(.bottom, 2)
            
            RatingView(rating: CGFloat(Double.random(in: 1...4.5)), maxRating: 5)
                .padding(.bottom, 2)
            
            Text(manga.attributes.tags
                .compactMap { $0.attributes.name.en ?? "" }
                .joined(separator: ", "))
            .font(FontFamily.SFPro.light.swiftUIFont(size: 14))
            .foregroundStyle(Asset.Colors.grayBase.swiftUIColor)
            .lineLimit(1)
            
        }
    }
}

