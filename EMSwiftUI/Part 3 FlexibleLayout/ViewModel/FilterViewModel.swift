//
//  FilterViewModel.swift
//  EMSwiftUI
//
//  Created by Aleksandr Moskovtsev on 28.10.2024.
//

import Foundation

final class FilterViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published var activeFilters: [String]
    
    // MARK: - Initialization
    init(activeFilters: [String]) {
        self.activeFilters = activeFilters
    }
    
    // MARK: - Public Methods
    func toggleTag(_ tag: String) {
            if let tagIndex = activeFilters.firstIndex(of: tag) {
                activeFilters.remove(at: tagIndex)
            } else {
                activeFilters.append(tag)
        }
    }
    
    func resetFilters() {
        activeFilters.removeAll()
    }
    
    func applyFilters() {
        print("Apply Button pressed")
    }
}
