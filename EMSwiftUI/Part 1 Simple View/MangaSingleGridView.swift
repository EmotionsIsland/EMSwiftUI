//
//  MangaSingleGridView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSingleGridView: View {
    @ObservedObject var viewModel: MangaListViewModel
    let manga: MangaData
    @State private var url: URL?
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            GridImageView(imageURL: url)
                
            Text(manga.attributes.title.en ?? "")
                .font(.custom(FontFamily.SFPro.semibold, size: 16))
            RatingView(rating: Double.random(in: 1...5), maxRating: 5)
            Text(manga.attributes.tags.compactMap{ $0.attributes?.name.en}.joined(separator: ", "))
                .font(.custom(FontFamily.SFPro.light, size: 14))
                .foregroundColor(Color(red: 0.77, green: 0.77, blue: 0.77))
        }
        .frame(maxWidth: 100)
        .frame(height: 208)
        .onAppear {
            url =  viewModel.getCoverURL(manga: manga, sizeFormat: .size512)
        }
    }
}

struct GridImageView: View {
    let imageURL: URL?
    var body: some View {
        AsyncImage(url: imageURL) { image in
            image.resizable()
                .resizedToFill(width: 100, height: 144)
                .cornerRadius(8)
                .padding(.bottom, 4)
        } placeholder: {
            ProgressView()
                .frame(width: 100, height: 144)
                .padding(.bottom, 4)
        }
    }
}
