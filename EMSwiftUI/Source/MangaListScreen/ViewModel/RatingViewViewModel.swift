//
//  RatingViewViewModel.swift
//  EMSwiftUI
//
//  Created by Антон Баландин on 31.03.25.
//

import Foundation

final class RatingViewViewModel {
    let maxRating: Int = 5
    
    var getRandomRating: CGFloat {
        CGFloat.random(in: 1...5)
    }
    
    func fillRatio(for index: Int, rating: CGFloat) -> CGFloat {
        return index < Int(rating) ? 1 : 0
    }
}
