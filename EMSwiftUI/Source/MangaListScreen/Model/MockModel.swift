//
//  MockModel.swift
//  EMSwiftUI
//
//  Created by Денис Ефименков on 06.02.2026.
//

import Foundation

struct MangaUIModel: Identifiable {
    let id: UUID = UUID()
    let title: String
    let rating: Double
    let subtitle: String
    let coverName: String
}

enum MangaMocks {
    static let popular: [MangaUIModel] = [
        .init(title: "Solo Leveling 1", rating: 4.5, subtitle: "Award Winning", coverName: "solo"),
        .init(title: "Solo Leveling 2", rating: 4.3, subtitle: "Award Winning", coverName: "solo"),
        .init(title: "Solo Leveling 3", rating: 4.2, subtitle: "Award Winning", coverName: "solo"),
        .init(title: "Solo Leveling 4", rating: 4, subtitle: "Award Winning", coverName: "solo"),
        .init(title: "Solo Leveling 5", rating: 4, subtitle: "Award Winning", coverName: "solo"),
        .init(title: "Solo Leveling 6", rating: 4, subtitle: "Award Winning", coverName: "solo")
    ]
}
