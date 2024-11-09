//
//  Section.swift
//  EMSwiftUI
//
//  Created by Aleksandr Moskovtsev on 27.10.2024.
//

import Foundation

enum Section: CaseIterable {
    
    case contentRating
    case publicationStatus
    case magazineDemographic
    case format
    case genre
    case theme
}

extension Section: Identifiable {
    
    var id: String { String(describing: self) }
}
