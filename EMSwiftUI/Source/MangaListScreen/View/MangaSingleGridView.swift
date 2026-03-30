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
        VStack(alignment: .leading, spacing: 8) {
            AsyncImage(url: API.coverURL(for: manga)) { image in
                image
                    .resizedToFill(width: 100, height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            } placeholder: {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 100, height: 150)
            }
            
            Text(titleText)
                .font(.custom("SFProText-Medium", size: 14))
                .foregroundColor(.blackBase)
                .lineLimit(2)
            
            RatingView(rating: 3.5)
            
            Text(tagsText)
                .font(.SFPro.lightSmall)
                .foregroundColor(.gray)
                .lineLimit(1)
                .truncationMode(.tail)
        }
    }

    private var titleText: String {
        if let title = manga.attributes.title.primary, !title.isEmpty {
            return title
        }

        return manga.attributes.altTitles
            .compactMap(\.value)
            .first(where: { !$0.isEmpty }) ?? "No title"
    }

    private var tagsText: String {
        let tags = manga.attributes.tags
            .compactMap(\.attributes.name.english)
            .filter { !$0.isEmpty }

        guard !tags.isEmpty else {
            return "No tags"
        }

        return tags.prefix(3).joined(separator: ", ")
    }
}
