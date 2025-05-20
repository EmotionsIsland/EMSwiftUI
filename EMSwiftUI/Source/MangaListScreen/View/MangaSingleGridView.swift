//
//  MangaSingleGridView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSingleGridView: View {
    let manga: MangaData
    let rating = Double.random(in: 3...5)
    let viewModel: any MangaListViewModel
    
    var body: some View {
        let coverURL = viewModel.getCoverURL(for: manga)
        VStack(alignment: .leading) {
            AsyncImage(url: coverURL) { image in
                image
                    .resizable()
                    .frame(height: 180)
                    .scaledToFit()
                    .cornerRadius(4)
            } placeholder: {
                Color.gray
                    .frame(height: 180)
                    .cornerRadius(4)
            }
            
            Text(manga.attributes.title.en ?? "Missing Title")
                .font(Font.SFPro.semiboldNormal)
                .lineLimit(1)
            
            RatingView(rating: CGFloat(rating), maxRating: 5)
        }
    }
}
