//
//  MangaSingleGridView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSingleGridView: View {
    
    let mangaData: MangaData
    let mangaListViewModel: MangaListViewModel
    
    var body: some View {
        Button(action: {
            mangaListViewModel.mangaWasTapped(mangaData: mangaData)
        }, label: {
            VStack {
                // TODO: Create single grid View
                    
                CustomAsyncImage(url: mangaListViewModel.getCoverURL(manga: mangaData, sizeFormat: .size256))
                    .frame(width: 100, height: 144)
                
                VStack(alignment: .leading) {
                    Text(mangaListViewModel.getTitle(mangaData: mangaData))
                        .foregroundStyle(Color(red: 56/255, green: 56/255, blue: 56/255))
                        .font(.custom(FontFamily.SFPro.semibold, size: 16))
                        .lineLimit(1)
                    RatingView(rating: CGFloat.random(in: 0...5), maxRating: 5)
                    Text(mangaListViewModel.getTags(mangaData: mangaData))
                        .foregroundStyle(Color(red: 196/255, green: 196/255, blue: 196/255))
                        .font(.custom(FontFamily.SFPro.light, size: 14))
                        .lineLimit(1)
                }
                .frame(width: 100, height: 66)
            }
            .frame(width: 100, height: 210)
        })
    }
}

#Preview {
    MangaSingleGridView(mangaData: .mock, mangaListViewModel: MangaListViewModel(mangaService: MangaListService(network: Network())))
}
