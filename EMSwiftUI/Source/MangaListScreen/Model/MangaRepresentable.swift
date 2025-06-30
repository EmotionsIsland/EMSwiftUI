//
//  MangaRepresentable.swift
//  EMSwiftUI
//
//  Created by Ruslan on 24.06.2025.
//

import Foundation

struct MangaRepresentable: Identifiable {
    let id: String
    let title: String
    let genres: [String]
    let raing: Double = .random(in: 1...5)
    let imageUrl: URL?
}
