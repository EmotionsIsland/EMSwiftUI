//
//  RatingView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct RatingView: View {
    
    @StateObject private var viewModel: MangaRatingViewModel
    
    private let maxRating: Int
    
    init(mangaId: String, maxRating: Int) {
        let viewModel = MangaRatingViewModel(mangaId: mangaId,
                                             service: MangaRatingService(network: Network()))
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.maxRating = maxRating
    }
    
    var body: some View {
        ZStack {
            starsView()
                .overlay(alignment: .leading) {
                    overlayView()
                        .mask(starsView())
                }
        }
    }
}

private extension RatingView {
    func starsView() -> some View {
        HStack(spacing: 0) {
            ForEach(0..<maxRating, id: \.self) { value in
                Image(systemName: "star.fill")
                    .foregroundColor(.gray)
            }
        }
    }
    
    func overlayView() -> some View {
        GeometryReader { proxy in
           Rectangle()
                .foregroundStyle(.yellow)
                .frame(width: (viewModel.average / 2) / Double(maxRating) * proxy.size.width)
                .animation(.spring, value: viewModel.average)
        }
    }
}
