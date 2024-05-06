//
//  MangaSingleGridView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSingleGridView: View {
    let manga: MangaData
    let imageURL: URL
    
    var body: some View {
        VStack {
            mangaImage(url: imageURL)
            
            mangaInfo(id: manga.id,
                      attributes: manga.attributes)
        }
        .onAppear {
            print(imageURL)
        }
    }
}


private extension MangaSingleGridView {
    func mangaImage(url: URL) -> some View {
        AsyncImage(url: url) { image in
            image
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 140)
                .clipShape(.rect(cornerRadius: 4))
        } placeholder: {
            RoundedRectangle(cornerRadius: 4)
                .fill(.gray)
                .frame(width: 100, height: 140)
        }
    }
    
    func mangaInfo(id: String, attributes: Attributes) -> some View {
        VStack {
            Text(attributes.title.en ?? "Not title")
                .font(.headline)
                .lineLimit(1)
            
            RatingView(mangaId: id, maxRating: 5)
            
            if let tagTitle = attributes.tags.first?.attributes.name.en {
                Text(tagTitle)
                    .font(.callout)
                    .foregroundStyle(.gray)
                    .lineLimit(1)
            }
        }
    }
}

