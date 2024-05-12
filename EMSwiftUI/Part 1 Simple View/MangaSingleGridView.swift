//
//  MangaSingleGridView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSingleGridView: View {
    @EnvironmentObject var viewModel: MangaListViewModel
    @State var rating: Double = 0
    
    let manga: MangaData?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if let manga = manga {
                AsyncImage(url: viewModel.getCoverURL(manga: manga,
                                                      sizeFormat: .size512)) { image in
                    image
                        .resizedToFill(width: 100, height: 144)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                } placeholder: {
                    RoundedRectangle(cornerRadius: 4)
                        .frame(height: 144)
                        .foregroundStyle(.grayBase)
                }
                .padding(.bottom, 4)
            }
            
            Text(manga?.attributes.title.en ?? "No eng title")
                .font(.custom(FontFamily.SFPro.semibold, size: 16))
                .lineLimit(1)
                .foregroundStyle(.blackBase)
            
            RatingView(rating: rating, maxRating: 5)
                .task {
                    await fetchRating()
                }
            
            if let tags = manga?.attributes.tags {
                Text(tags.first?.attributes.name.en ?? "")
                    .font(.custom(FontFamily.SFPro.light, size: 14))
                    .lineLimit(1)
                    .foregroundStyle(.grayBase)
            }
        }
    }
}

private extension MangaSingleGridView {
    func fetchRating() async {
        guard let manga = manga else { return }
        guard let fetchedRating = await viewModel.getRating(manga: manga) else { return }
        rating = fetchedRating
    }
}
