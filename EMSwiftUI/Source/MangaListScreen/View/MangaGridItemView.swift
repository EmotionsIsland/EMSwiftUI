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
        manga.attributes.title.en ?? "No eng title"
    }

    private var subtitle: String {
        manga.attributes.tags.first?.attributes.name.en ?? ""
    }

    private var coverURL: URL? {
        API.coverURL(for: manga, .size512)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            AsyncImage(url: coverURL) { phase in
                switch phase {
                case .empty:
                    RoundedRectangle(cornerRadius: 12)
                        .frame(height: 150)
                        .foregroundStyle(.quaternary)

                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 150)
                        .frame(maxWidth: .infinity)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .clipped()

                case .failure:
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundStyle(.quaternary)
                        Image(systemName: "photo")
                            .foregroundStyle(.secondary)
                    }
                    .frame(height: 150)

                @unknown default:
                    EmptyView()
                }
            }

            Text(title)
                .font(.SFPro.semiboldNormal)
                .fontWeight(.semibold)
                .foregroundStyle(Color.blackBase)
                .lineLimit(1)

            RatingView(rating: 4.5, maxRating: 5)

            Text(subtitle.isEmpty ? " " : subtitle)
                .font(.SFPro.lightSmall)
                .foregroundStyle(Color.grayBase)
                .lineLimit(1)
        }
    }
}
