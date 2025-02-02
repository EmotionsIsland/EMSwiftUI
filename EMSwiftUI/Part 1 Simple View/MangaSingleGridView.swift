//
//  MangaSingleGridView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSingleGridView: View {
    let manga: MangaData
    let viewModel: MangaListViewModel

    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: viewModel.getCoverURL(manga: manga, sizeFormat: .size256)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .scaledToFit()
            .frame(width: 100, height: 150)
            .cornerRadius(10)

            Text(manga.attributes.title.en ?? "Unknown")
                .font(.headline)
                .lineLimit(2)

            RatingView(rating: viewModel.getRating(manga: manga), maxRating: 5)

            Text(manga.attributes.publicationDemographic ?? "Unknown Genre")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .frame(width: 120)
    }
}
