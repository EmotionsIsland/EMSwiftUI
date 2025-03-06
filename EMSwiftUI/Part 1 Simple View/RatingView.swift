//
//  RatingView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct RatingView: View {
    
    let rating: CGFloat
    let maxRating: Int
    
    private let starSize: CGFloat = 16 // Размер звезды
    
    var body: some View {
        VStack {
            // TODO: Create star rating View
            HStack{
                ForEach(0..<maxRating, id: \.self) { number in
                    starView(for: number)
                }
            }
            .frame(width: 100, height: 16)
        }
    }
}

private extension RatingView {
    
    private func starView(for number: Int) -> some View {
        let fillWidth = fillWidth(for: number)
        
        return ZStack {
            Asset.Icons.starIcon.swiftUIImage
                .resizable()
                .scaledToFit()
                .foregroundStyle(.gray)
            
            Asset.Icons.starIcon.swiftUIImage
                .resizable()
                .scaledToFit()
                .foregroundStyle(.yellow)
                .mask(
                    Rectangle()
                        .frame(width: fillWidth * starSize, height: starSize)
                        .offset(x: -starSize / 2 + fillWidth * starSize / 2)
                )
        }
        .frame(width: starSize, height: starSize)
    }
    
    // Вычисляем ширину заполнения для звезды
    private func fillWidth(for number: Int) -> CGFloat {
        let lowerBound = CGFloat(number)
        let upperBound = CGFloat(number + 1)
        
        if rating > upperBound {
            return 1.0 // Полностью заполненная звезда
        } else if rating > lowerBound {
            return rating - lowerBound // Частично заполненная звезда
        } else {
            return 0.0 // Пустая звезда
        }
    }
}

#Preview {
    RatingView(rating: 3.5, maxRating: 5)
}
