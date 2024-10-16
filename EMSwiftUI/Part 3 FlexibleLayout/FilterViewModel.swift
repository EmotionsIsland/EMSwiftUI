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
    
    private let filterService: FilterServiceProtocol
    
    init(filterService: FilterServiceProtocol = FilterService()) {
        self.filterService = filterService
    }
    
    var filterCategories: [(title: String, tags: [String])] {
        filterService.getFilterCategories()
    }
    
    func resetTags() {
        selectedTags.removeAll()
    }
    
    func toggleTagSelected(_ tag: String) {
        selectedTags.contains(tag)
        ? selectedTags.removeAll(where: { $0 == tag })
        : selectedTags.append(tag)
    }
}

