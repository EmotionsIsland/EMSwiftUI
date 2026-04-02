//
//  MangaSection.swift
//  EMSwiftUI
//
//  Created by Денис Ефименков on 01.04.2026.
//

import Foundation

struct MangaSection: Identifiable {
    let id: String
    let title: String
    let items: [MangaGridItemViewModel]
}

struct MangaSectionConfig {
    let id: String
    let title: String
    let sort: MangaSort
}
