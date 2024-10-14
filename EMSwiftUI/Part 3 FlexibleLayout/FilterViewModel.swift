//
//  FilterViewModel.swift
//  EMSwiftUI
//
//  Created by Денис Хафизов on 13.10.2024.
//

import Foundation
import Combine

final class FilterViewModel: ObservableObject {
    @Published var selectedTags: [String] = []
    
    let сontentRatingTags = ["All Ages", "13+", "16+", "18+"]
    let publicationStatusTags = ["Completed", "Ongoing", "On Hiatus"]
    let magazineDemographicTags = ["Shounen", "Shoujo","Seinen", "Josei", "Kodomo"]
    let formatTags = ["Manga", "Manhwa", "Manhua", "Webtoon"]
    let genreTags = ["Action", "Romance", "Comedy", "Drama", "Mystery", "Horror", "Fantasy", "Science Fiction", "Adventure", "Sports", "Historical"]
    let themeTags = ["School Life", "Magic", "Superpowers", "Isekai", "Post-apocalypse", "Cyberpunk", "Martial Arts", "Samurai", "War", "Pirates", "Vampires", "Friendship", "Love Triangle"]
    
    func resetTags() {
        selectedTags.removeAll()
    }
    
    func toggleTagSelected(_ tag: String) {
        if selectedTags.contains(tag) {
            selectedTags.removeAll(where: { $0 == tag })
        } else {
            selectedTags.append(tag)
        }
    }
}
