//
//  MangaModel.swift
//  EMSwiftUI
//
//  Created by Danila Umnov on 20.07.2026.
//

import Foundation

struct MangaModel: Identifiable {
    let id: String
    let coverUrl: URL?
    let title: String
    let genres: [String]
    let rating: Double = .random(in: 3...5)
}
