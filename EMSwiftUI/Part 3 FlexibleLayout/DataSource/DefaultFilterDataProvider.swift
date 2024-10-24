//
//  DefaultFilterDataProvider.swift
//  EMSwiftUI
//
//  Created by Александра Сергеева on 21.10.2024.
//

import Foundation

enum DefaultFilterDataProvider {
    static func getDataFor(_ filter: FilterType) -> FilterModel {
        let filterModel: FilterModel
        
        switch filter {
        case .theme:
            filterModel = FilterModel(filterType: .theme, tags: [
                "Action", "Adventure", "Comedy", "Drama", "Fantasy",
                "Historical", "Horror", "Mystery", "Psychological", "Romance",
                "Sci-Fi", "Slice of Life", "Sports", "Supernatural", "Thriller"
            ])
        case .genre:
            filterModel = FilterModel(filterType: .genre, tags: [
                "Shounen", "Shoujo", "Seinen", "Josei", "Kodomo",
                "Mecha", "Isekai", "Yuri", "Yaoi", "Harem",
                "Reverse Harem", "School Life", "Martial Arts", "Magic"
            ])
        case .rating:
            filterModel = FilterModel(filterType: .rating, tags: [
                "1", "2", "3", "4", "5"
            ])
        case .status:
            filterModel = FilterModel(filterType: .status, tags: [
                "Ongoing", "Completed", "Hiatus", "Cancelled", "Discontinued"
            ])
        case .demographic:
            filterModel = FilterModel(filterType: .demographic, tags: [
                "Shounen", "Shoujo", "Seinen", "Josei", "Kodomo"
            ])
        case .format:
            filterModel = FilterModel(filterType: .format, tags: [
                "Manga", "Manhwa", "Manhua", "Doujinshi", "Light Novel",
                "Webtoon", "One-shot", "4-Koma", "Anthology"
            ])
        }
        return filterModel
    }
    
}
