//
//  FilterViewModel.swift
//  EMSwiftUI
//
//  Created by Александра Сергеева on 21.10.2024.
//

import SwiftUI

final class FilterViewModel: ObservableObject {
    @Published private(set) var selectedTags: [String] = []
    @Published private(set) var tags: [FilterType: [String]] = [:]
    
    init() {
        loadTags()
    }
    
    func resetFilterTapped() {
        selectedTags.removeAll()
    }
    
    func applyFilterTapped() {
        print("Applied filters: \(selectedTags)")
    }
    
    func removeOrAppendTag(_ tag: String) {
        if selectedTags.contains(tag) {
            selectedTags.removeAll { $0 == tag }
        } else {
            selectedTags.append(tag)
        }
    }
    
}

private extension FilterViewModel {
    func loadTags() {
       for filter in FilterType.allCases {
           tags[filter] = DefaultFilterDataProvider.getDataFor(filter).tags
       }
   }

}
