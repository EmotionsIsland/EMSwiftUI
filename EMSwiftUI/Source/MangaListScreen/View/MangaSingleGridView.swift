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
            coverImage
            VStack(spacing: 2) {
                Text(manga.displayTitle)
                    .font(.system(size: 16, weight: .semibold))
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                RatingView(rating: 4)
                
                Text(manga.genresString)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    
    private var coverImage: some View {
        GeometryReader { geometry in
            if let coverURL = API.coverURL(for: manga, .size256) {
                AsyncImage(url: coverURL) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width, height: 146)
                            .clipped()
                            .cornerRadius(8)
                    default:
                        EmptyView()
                    }
                }
            }
        }
        .frame(height: 146)  // фиксированная высота для GeometryReader
    }
}
