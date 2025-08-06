//
//  MangaSingleGridView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSingleGridView: View {
    let item: MangaData
    
    // Константы для размеров и стилей
    private enum Constants {
        static let coverWidth: CGFloat = 100
        static let coverHeight: CGFloat = 144
        static let cornerRadius: CGFloat = 4
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            mangaCoverView

            Text(item.attributes.title.en ?? "No eng title")
                .font(Font.SFPro.semiboldNormal)
                .lineLimit(1)
            
            RatingView(rating: 4.2, maxRating: 5)
            
            Text(genresText)
                .font(Font.SFPro.lightSmall)
                .lineLimit(1)
                .foregroundColor(.gray)
        }
        .frame(width: Constants.coverWidth)
    }
    
    // Обложка манги
    private var mangaCoverView: some View {
        ZStack {
            if let url = item.coverURL {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                    case .failure:
                        Rectangle()
                            .fill(.gray)
                    case .empty:
                        ProgressView()
                    @unknown default:
                        Rectangle()
                            .fill(.gray)
                    }
                }
            } else {
                Rectangle()
                    .fill(.gray)
            }
        }
        .frame(width: Constants.coverWidth, height: Constants.coverHeight)
        .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius))
    }
    
    // Жанры
    private var genresText: String {
        item.attributes.tags
            .filter { $0.attributes.group == "genre" }
            .map { $0.attributes.name.en ?? "" }
            .joined(separator: ", ")
    }
}
