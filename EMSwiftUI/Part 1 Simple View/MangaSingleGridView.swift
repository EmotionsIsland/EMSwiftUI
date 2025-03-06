//
//  MangaSingleGridView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSingleGridView: View {
    let mangaImage: String
    let mangaTitle: String
    let mangarating: Double
    let description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Image(mangaImage)
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: Const.Layout.radius))
            Text(mangaTitle)
                .font(.custom(FontFamily.SFPro.semibold,
                              size: Const.Text.mediumSize))
                .lineLimit(1)
            RatingView(rating: mangarating)
            Text(description)
                .font(.custom(FontFamily.SFPro.regular,
                              size: Const.Text.smallSize))
                .foregroundStyle(Const.Colors.gray)
                .lineLimit(1)
        }
    }
}

#Preview {
    MangaSingleGridView(mangaImage: "mockImage1", 
                        mangaTitle: "I Was Reincarnated as the 7th Prince so I Will Perfect My Magic as I Please",
                        mangarating: 4.5,
                        description: " Adventure, Comedy, Ecchi, Fantasy, Harem, Manga, Shounen, Slice of Life")
}
