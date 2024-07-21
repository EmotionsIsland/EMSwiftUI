//
//  MangaSingleGridView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSingleGridView: View {
    let mangaData: [MangaData]
    let viewModel: MangaListViewModel

    var body: some View {
        VStack {
            LazyVGrid(columns: [
                GridItem(.fixed(100)),
            ], spacing: 8, content: {
                ForEach(0..<2, id: \.self) { index in
                    VStack(spacing: 4) {
                        let url = viewModel.getCoverURL(
                            manga: mangaData[index],
                            sizeFormat: .size512
                        )
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .frame(width: 100, height: 144)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                            } placeholder: {
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(.orangeBase)
                                    .frame(width: 100, height: 140)
                            }
                            .onTapGesture {
                                print(url)
                            }
                        
                        VStack(alignment: .leading ,spacing: 2) {
                            Text(mangaData[index].attributes.title.en ?? "No information")
                                .font(FontFamily.SFPro.medium.swiftUIFont(size: 16))
                                .foregroundStyle(.blackBase)
                                .lineLimit(1)
                            
                            RatingView()
                            
                            Text(mangaData[index].attributes.description.en ?? "No information")
                                .font(FontFamily.SFPro.light.swiftUIFont(size: 14))
                                .foregroundStyle(.grayBase)
                                .lineLimit(1)
                        }
                    }
                }
            })
        }
    }
}
