//
//  MangaGridItemViewModel.swift
//  EMSwiftUI
//
//  Created by Денис Ефименков on 10.03.2026.
//

import Foundation
import Netify
import SwiftUI

final class MangaGridItemViewModel: ObservableObject, Identifiable {
    let id = UUID()
    private let manga: MangaData

    init(manga: MangaData) {
        self.manga = manga
    }

    var title: String {
        manga.attributes.mangaTitle
    }

    var subtitle: String {
        manga.attributes.mangaSubtitle
    }

    var coverURL: URL? {
        API.coverURL(for: manga, .size512)
    }

    var rating: Double {
        Double(manga.attributes.contentRating) ?? 4.7
    }
}
