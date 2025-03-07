//
//  MangaSingleGridView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSingleGridView: View {
    let manga: MangaData
    let width: CGFloat
    @EnvironmentObject var mangaViewModel: MangaListViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            mangaCover
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
    
    var mangaCover: some View {
        AsyncImage(url: mangaViewModel.getCoverURL(manga: manga, sizeFormat: .size512)) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizedToFillAndRounded(width: width, height: Const.Layout.imageAspectRatio*width)
            case .failure:
                Image(systemName: "exclamationmark.triangle")
                    .resizedToFitAndRounded(width: width, height: Const.Layout.imageAspectRatio*width)
            @unknown default:
                Image(systemName: "book.pages")
                    .resizedToFitAndRounded(width: width, height: Const.Layout.imageAspectRatio*width)
            }
        }
    }
}
