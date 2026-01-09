//
//  RatingView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct RatingView: View {
    let rating: CGFloat
    let maxRating = 5
    
    var body: some View {
        HStack(spacing: 2) {
            ForEach(0..<maxRating, id: \.self) { index in
                Image(systemName: starType(for: index))
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color(red: 1.0, green: 0.84, blue: 0.0))
                    .font(.system(size: 20, weight: .bold))  
            }
        }
    }
    
    private func starType(for index: Int) -> String {
        let position = CGFloat(index) + 1.0
        
        if rating >= position {
            return "star.fill"
        } else if rating > CGFloat(index) {
            return "star.leadinghalf.filled"
        } else {
            return "star"
        }
    }
}
