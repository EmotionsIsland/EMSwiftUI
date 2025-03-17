//
//  FilterViewModel.swift
//  EMSwiftUI
//
//  Created by Kristina Grebneva on 17.03.2025.
//

import Foundation

class FilterViewModel: ObservableObject {
    @Published private(set) var filters: [String: [String]]
    @Published private(set) var pickedFilters: Set<String>
    
    init() {
        self.filters = [:]
        self.pickedFilters = Set<String>()
        getFilters()
    }
    
    private func getFilters() {
        var mockFilters: [String: [String]] = [:]
        mockFilters["Content Rating"] = ["All Ages", "Teen (13+)", "Mature (17+)", "Explicit (18+)"]
        mockFilters["Publication Status"] = ["Ongoing", "Completed", "Hiatus", "Cancelled"]
        mockFilters["Magazine Demographic"] = ["Young boys", "Young girls", "Adult men", "Adult women", "Children"]
        mockFilters["Format"] = ["Manga", "One-Shot", "Light Novel", "Doujinshi", "Webtoon", "Anthology"]
        mockFilters["Genre"] = ["Action", "Romance", "Comedy", "Horror", "Fantasy", "Sci-Fi", "Slice of Life"]
        mockFilters["Theme"] = ["Adventure", "Supernatural", "Psychological", "Historical", "Sports", "Mystery"]
        filters = mockFilters
    }
    
    // MARK: - Intents
    func pickFilter(_ filter: String) {
        pickedFilters.insert(filter)
    }
    
    func checkPicking(_ filter: String) -> Bool {
        return pickedFilters.contains(filter)
    }
    
    func removeAllFilters() {
        pickedFilters.removeAll()
    }
}
