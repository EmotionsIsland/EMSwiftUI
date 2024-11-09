//
//  SectionModel.swift
//  EMSwiftUI
//
//  Created by Aleksandr Moskovtsev on 27.10.2024.
//

import Foundation

struct SectionModel: Identifiable {
    
    let id = UUID()
    let title: String
    let tags: [String]
}

extension SectionModel {
    
    init(section: Section) {
        switch section {
        case .contentRating:
            self.title = "Content Rating"
            self.tags = ["⭐️", "⭐️⭐️", "⭐️⭐️⭐️", "⭐️⭐️⭐️⭐️", "⭐️⭐️⭐️⭐️⭐️"]
        case .publicationStatus:
            self.title = "Publication Status"
            self.tags = ["Ongoing", "Completed", "Upcoming", "Cancelled"]
        case .magazineDemographic:
            self.title = "Magazine Demographic"
            self.tags = ["Adult", "Teen", "Youth", "Family", "Children"]
        case .format:
            self.title = "Format"
            self.tags = ["Monthly", "Quarterly", "Yearly"]
        case .genre:
            self.title = "Genre"
            self.tags = ["Action", "Comedy", "Drama", "Fantasy", "Horror"]
        case .theme:
            self.title = "Theme"
            self.tags = ["Science Fiction", "Dark Fantasy", "Steampunk"]
        }
    }
}
