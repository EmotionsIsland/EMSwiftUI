//
//  MangaSingleGridView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

// MARK: - MangaSingleGridView
struct MangaSingleGridView: View {
    var body: some View {
        VStack {
            MangaCover()
            
            MangaTitle(title: "Manga")

            RatingView(rating: 2.3, maxRating: 5)

            MangaGenre(genres: ["Action", "Sci-Fi", "Horror"])
        }
    }
}

#Preview {
    MangaSingleGridView()
}

// MARK: - MangaCover
struct MangaCover: View {
    
    var body: some View {
        Image(systemName: "lock.document")
            .resizable()
            .scaledToFit()
            .scaleEffect(0.5)
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
