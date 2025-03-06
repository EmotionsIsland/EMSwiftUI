//
//  RatingView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct RatingView: View {
    let rating: Double
    
    var body: some View {
        HStack(spacing: Const.Layout.starPadding) {
            ForEach(Array(1...Const.Other.maxRating), id: \.self) { index in
                image(for: index)
            }
        }
    }
    
    // функция возвращает изображение звезды рейтинга
    // (пустая, закрашенная или закрашенная наполовину)
    private func image(for index: Int) -> some View {
        let number = Double(index)
        switch number {
        case let number where number <= rating:
            return Asset.Icons.filledStar.swiftUIImage
                .resizedToFit()
        case let number where number - 1 < rating:
            return Asset.Icons.halfFilledStar.swiftUIImage
                .resizedToFit()
        default:
            return Asset.Icons.emptyStar.swiftUIImage
                .resizedToFit()
        }
    }
}

#Preview {
    RatingView(rating: 3.5)
}
