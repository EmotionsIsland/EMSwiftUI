//
//  MangaSingleGridView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSingleGridView<VM: MangaListViewModel>: View {
    let manga: MangaData
    let viewModel: VM

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            if let url = viewModel.getCover(for: manga) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 100, height: 144)
                    case .success(let image):
                        image
                            .frame(width: 100, height: 144)
                            .cornerRadius(4)
                    case .failure:
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.gray)
                            .frame(width: 100, height: 144)
                    @unknown default:
                        EmptyView()
                    }
                }
            } else {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.gray)
                    .frame(width: 100, height: 144)
            }
            
            VStack(alignment: .leading, spacing: 2) {
                let sortedTags = manga.attributes.tags
                    .sorted { ($0.attributes.name.en ?? "") < ($1.attributes.name.en ?? "") }
                    .prefix(2)
                    .compactMap({$0.attributes.name.en})
                
                Text(manga.attributes.title.en ?? "No Title")
                    .font(.SFPro.semiboldNormal)
                    .lineLimit(1)
                    .multilineTextAlignment(.leading)
                
                RatingView(rating: CGFloat(viewModel.rating(for: manga)))
                    .frame(height: 20)
                
                HStack(spacing: 4) {
                    Text(sortedTags.joined(separator: ","))
                        .lineLimit(1)
                        .font(.SFPro.lightSmall)
                }
            }
        }
        .frame(width: 100)
    }
}
