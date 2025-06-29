//
//  MangaSectionType.swift
//  EMSwiftUI
//
//  Created by Katerina Ivanova on 29.06.2025.
//

enum MangaSectionType: CaseIterable {
    case popular
    case recentlyAdded
    case lastUpdates
    case seasonal
    
    var title: String {
        switch self {
        case .popular:
            return "Popular"
        case .recentlyAdded:
            return "Recently Added"
        case .lastUpdates:
            return "Last Updates"
        case .seasonal:
            return "Seasonal"
        }
    }
    
    func filter(list: [MangaData], using viewModel: MangaListViewModelImpl) -> [MangaData] {
        switch self {
        case .popular:
            return list.sorted { $0.attributes.rating > $1.attributes.rating }
        case .recentlyAdded:
            return list.sorted { $0.attributes.createdAt > $1.attributes.createdAt }
        case .lastUpdates:
            return list.sorted { $0.attributes.updatedAt > $1.attributes.updatedAt }
        case .seasonal:
            return list.filter {
                viewModel.isDateIsCurrentSeason(dateString: $0.attributes.createdAt)
            }
        }
    }
}
