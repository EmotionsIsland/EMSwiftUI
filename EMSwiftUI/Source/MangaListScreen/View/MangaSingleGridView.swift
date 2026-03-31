//
//  MangaSingleGridView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI
import Netify

struct MangaSingleGridView: View {
    let manga: MangaData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            ZStack {
                Color.gray.opacity(0.3)
                
                if let url = API.coverURL(for: manga, .size256) {
                    AsyncImage(url: url) { image in
                        image.resizedToFill(width: 100, height: 144)
                    } placeholder: {
                        ProgressView()
                    }
                } else {
                    Image(systemName: "photo")
                        .foregroundStyle(Color.gray)
                }
            }
            .frame(width: 100, height: 144)
            .cornerRadius(8)
            .clipped()
            
            let titleText = manga.attributes.title.en
                ?? manga.attributes.altTitles.compactMap { $0.ru }.first
                ?? "No title"
            
            Text(titleText)
                .font(Font.SFPro.headline2)
                .lineLimit(1)
            
            RatingView(rating: 4.3, maxRating: 5)
            
            if let firstTag = manga.attributes.tags.first?.attributes.name.en {
                Text(firstTag)
                    .font(Font.SFPro.bodyNormal)
                    .foregroundStyle(Color.grayBase)
            } else {
                Text("Manga")
                    .font(Font.SFPro.bodyNormal)
                    .foregroundStyle(Color.grayBase)
            }
        }
    }
}
