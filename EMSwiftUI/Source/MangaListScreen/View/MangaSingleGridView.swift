//
//  MangaSingleGridView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSingleGridView<ViewModel: MangaListViewModel>: View {
    let manga: SingleGridMangaModel
    @StateObject private var viewModel: ViewModel
    
    init(manga: SingleGridMangaModel, viewModel: ViewModel) {
        self.manga = manga
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(spacing: 4) {
            MangaCoverView(url: manga.url)
            VStack(spacing: 0) {
                Text(manga.title)
                    .font(.custom("SFProText-Semibold", size: 16))
                    .frame(width: 100, height: 20, alignment: .leading)
                    .foregroundStyle(Color(red: 56/255, green: 56/255, blue: 56/255))
                MangaRatingView(rating: manga.rating, maxRating: 5)
                    .frame(width: 100, height: 16)
                Text(manga.tags.joined(separator: ", "))
                    .font(.custom("SFProDisplay-Light", size: 14))
                    .frame(width: 100, height: 20, alignment: .leading)
                    .foregroundStyle(Color(red: 196/255, green: 196/255, blue: 196/255))
            }
        }
        .frame(width: 100, height: 208)
    }
}
