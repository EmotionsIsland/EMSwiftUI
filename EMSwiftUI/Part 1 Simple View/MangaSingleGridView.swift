//
//  MangaSingleGridView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSingleGridView: View {
    @ObservedObject var viewModel: MangaListViewModel
    let model: MangaData
    
    var body: some View {
        VStack(spacing: 3) {
            if let url = viewModel.getCoverURL(manga: model, sizeFormat: .size512) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .frame(width: 100, height: 144)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                } placeholder: {
                    ProgressView()
                }
            }
            
            Text(model.attributes.title.en ?? "No name")
                .lineLimit(1)
                .font(.custom(FontFamily.SFPro.bold, size: 16))
            
            RatingView(rating: 3, maxRating: 5)
            
            Text(model.attributes.tags.first?.attributes.name.en ?? "No tags")
                .lineLimit(1)
                .foregroundStyle(.grayBase)
        }
    }
}
