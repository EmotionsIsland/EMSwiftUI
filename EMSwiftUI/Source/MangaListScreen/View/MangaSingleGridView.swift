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
            
            Text(manga.attributes.title.english ?? "No title")
                .font(.SFPro.lightSmall)
                .foregroundColor(Color("PrimaryTextColor"))
                .lineLimit(1)
            
            RatingView(rating: 3.5)
        }
    }
}
