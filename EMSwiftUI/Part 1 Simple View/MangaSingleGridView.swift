//
//  MangaSingleGridView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

// MARK: - MangaSingleGridView
struct MangaSingleGridView: View {
    
    // MARK: - Properties
    let manga: MangaData
    let viewModel: MangaListViewModel
    
    // MARK: - Body
    var body: some View {
        VStack {
            MangaCover(imageURL: viewModel.getCoverURL(manga: manga, sizeFormat: .size256))
            
            MangaTitle(title: manga.attributes.title.en ?? "No title")
            
            RatingView(rating: 3.6, maxRating: 5)
            
            MangaGenre(genres: manga.attributes.tags.map { $0.attributes.name.en ?? "No genre" })
        }
    }
}

// MARK: - MangaCover
struct MangaCover: View {
    
    let imageURL: URL
    
    var body: some View {
        AsyncImage(url: imageURL) { image in
            image.resizable().scaledToFill()
        } placeholder: {
            ProgressView()
        }
        .frame(width: 100, height: 144)
        .background(Color.grayBase)
        .cornerRadius(4)
    }
}

// MARK: - MangaTitle
struct MangaTitle: View {
    
    var title: String
    
    var body: some View {
        Text(title)
            .lineLimit(1)
            .font(.custom(FontFamily.SFProText.medium, size: 16))
            .frame(width: 100, alignment: .leading)
    }
}

// MARK: - MangaGenre
struct MangaGenre: View {
    
    var genres: [String]
    
    var body: some View {
        Text(genres.joined(separator: ", "))
            .lineLimit(1)
            .font(.custom(FontFamily.SFProText.regular, size: 14))
            .frame(width: 100, alignment: .leading)
            .foregroundStyle(.grayBase)
    }
}
