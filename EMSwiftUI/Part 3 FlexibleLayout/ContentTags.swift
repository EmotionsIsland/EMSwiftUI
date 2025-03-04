//
//  FilterViewModel.swift
//  EMSwiftUI
//
//  Created by Гриша Шкробов on 04.03.2025.
//

import Foundation

struct ContentTags {
    let tags: [ContentTag]
    
    init() {
        // Преобразуем словарь в массив структур ContentTag
        self.tags = contentTagsDict.map { ContentTag(name: $0.key, tags: $0.value) }
    }
    
    // Исходный словарь с тегами
    private let contentTagsDict: [String: [String]] = [
        "Content Rating": [
            "All Ages", "Teen", "Mature", "Explicit", "PG-13", "Family Friendly", "Violence", "Language"
        ],
        "Publication Status": [
            "Ongoing", "Completed", "Hiatus", "Cancelled", "Upcoming", "Seasonal", "One-shot"
        ],
        "Magazine Demographic": [
            "Shonen", "Shojo", "Seinen", "Josei", "Kodomo", "General", "Niche"
        ],
        "Format": [
            "Manga", "Comic", "Graphic Novel", "Webtoon", "Light Novel", "Anthology", "One-shot"
        ],
        "Genre": [
            "Action", "Adventure", "Romance", "Fantasy", "Sci-Fi", "Horror", "Comedy", "Drama", "Mystery", "Slice of Life", "Historical", "Supernatural"
        ],
        "Theme": [
            "School Life", "Isekai", "Post-Apocalyptic", "Cyberpunk", "Mecha", "Sports", "Music", "Cooking", "Martial Arts", "Time Travel", "Vampires", "Zombies"
        ]
    ]
}

struct ContentTag: Identifiable{
    let id = UUID()
    let name: String
    let tags: [String]
}
