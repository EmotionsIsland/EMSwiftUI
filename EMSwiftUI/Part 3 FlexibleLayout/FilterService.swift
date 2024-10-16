//
//  FilterService.swift
//  EMSwiftUI
//
//  Created by Денис Хафизов on 16.10.2024.
//

import Foundation

protocol FilterServiceProtocol {
    func getFilterCategories() -> [(title: String, tags: [String])]
}

final class FilterService: FilterServiceProtocol {
    let contentRatingTags = ["All Ages", "13+", "16+", "18+"]
    let publicationStatusTags = ["Completed", "Ongoing", "On Hiatus"]
    let magazineDemographicTags = ["Shounen", "Shoujo", "Seinen", "Josei", "Kodomo"]
    let formatTags = ["Manga", "Manhwa", "Manhua", "Webtoon"]
    let genreTags = ["Action", "Romance", "Comedy", "Drama", "Mystery", "Horror", "Fantasy", "Science Fiction", "Adventure", "Sports", "Historical"]
    let themeTags = ["School Life", "Magic", "Superpowers", "Isekai", "Post-apocalypse", "Cyberpunk", "Martial Arts", "Samurai", "War", "Pirates", "Vampires", "Friendship", "Love Triangle"]
    
    func getFilterCategories() -> [(title: String, tags: [String])] {
        return [
            (title: "Content Rating Tags", tags: contentRatingTags),
            (title: "Publication Status", tags: publicationStatusTags),
            (title: "Magazine Demographic", tags: magazineDemographicTags),
            (title: "Format", tags: formatTags),
            (title: "Genre", tags: genreTags),
            (title: "Theme", tags: themeTags)
        ]
    }
}
