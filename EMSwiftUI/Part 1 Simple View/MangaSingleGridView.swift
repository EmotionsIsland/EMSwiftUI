//
//  MangaSingleGridView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSingleGridView: View {
    let manga: MangaData
    @EnvironmentObject var mangaViewModel: MangaListViewModel
    
    typealias Const = MangaListMainScreenModel.Const
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            MangaCover(url: mangaViewModel.getCoverURL(manga: manga, sizeFormat: .size512))
            Text(manga.attributes.unwrappedTitle)
                .font(.custom(FontFamily.SFPro.semibold,
                              size: Const.Text.mediumSize))
                .lineLimit(1)
            RatingView(rating: mangaViewModel.getRating(manga: manga))
            Text(manga.attributes.unwrappedDescription)
                .font(.custom(FontFamily.SFPro.regular,
                              size: Const.Text.smallSize))
                .foregroundStyle(Const.Colors.gray)
                .lineLimit(1)
        }
    }
}


