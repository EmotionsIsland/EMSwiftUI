//
//  MangaGridItemView.swift
//  EMSwiftUI
//
//  Created by Денис Ефименков on 06.02.2026.
//
import SwiftUI
import Netify

struct MangaGridItemView: View {
    let manga: MangaData

    private var title: String {
        manga.attributes.mangaTitle
    }

    private var subtitle: String {
        manga.attributes.mangaSubtitle
    }

    private var coverURL: URL? {
        API.coverURL(for: manga, .size512)
    }

    private let coverHeight: CGFloat = 144
    private let cornerRadius: CGFloat = 12

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            cover

            Text(title)
                .font(.SFPro.semiboldNormal)
                .fontWeight(.semibold)
                .foregroundStyle(Color.blackBase)
                .lineLimit(1)

            RatingView(rating: 4.5, maxRating: 5)

            Text(subtitle)
                .font(.SFPro.lightSmall)
                .foregroundStyle(Color.grayBase)
                .lineLimit(1)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var cover: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .foregroundStyle(.quaternary)
                
                AsyncImage(url: coverURL) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                        
                    case .failure:
                        Image(systemName: "photo")
                            .foregroundStyle(.secondary)
                        
                    case .empty:
                        EmptyView()
                        
                    @unknown default:
                        EmptyView()
                    }
                }
            }
            .frame(width: geometry.size.width)
            .frame(height: coverHeight)
            .clipped()
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        }
        .frame(height: coverHeight)
    }
}
