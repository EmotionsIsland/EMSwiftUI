//
//  MangaSingleGridView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSingleGridView: View {

    private let rating = 3.2

    @ObservedObject var mangaListViewModel: MangaListViewModel

    let mangaData: MangaData
    let imageURL: URL

    var body: some View {
        VStack {
            AsyncImage(url: imageURL) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 144)
                        .cornerRadius(10)
                case .failure:
                    Image(systemName: "xmark.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .foregroundColor(.red)
                @unknown default:
                    EmptyView()
                }
            }
            Text(mangaListViewModel.getTitle(for: mangaData))
                .font(.system(size: 14, weight: .bold))
                .frame(width: 100, height: 20, alignment: .leading )

            RatingView(rating: rating)

            Text(mangaListViewModel.getGenre(for: mangaData))
                .font(.system(size: 14, weight: .light))
                .frame(width: 100, height: 20, alignment: .leading )
                .foregroundStyle(.grayBase)
        }
    }
}
