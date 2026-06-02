//
//  MangaSection.swift
//  EMSwiftUI
//
//  Created by Дарья Саитова on 28.05.2026.
//

import Foundation

struct MangaSection: Identifiable {
    let id = UUID()
    let title: String
    let items: [MangaItem]
}

struct MangaItem: Identifiable {
    let id: String
    let title: String
    let genres: String
    let coverURL: URL?
    let rating: CGFloat
}
