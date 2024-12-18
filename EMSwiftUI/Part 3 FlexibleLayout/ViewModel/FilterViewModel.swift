//
//  FilterViewModel.swift
//  EMSwiftUI
//
//  Created by Максим Шишлов on 17.12.2024.
//

import Foundation

final class FilterViewModel: ObservableObject {
    
    @Published private(set) var sections: [FilterSection] = []
    @Published private(set) var selectedTags: [FilterTag] = []
    
    init() {
        loadMockData()
    }
    
    private func loadMockData() {
        sections = FilterMockData.sections
    }
    
    func toggleSection(_ section: FilterSection) {
        if let index = sections.firstIndex(where: { $0.id == section.id }) {
            sections[index].isExpanded.toggle()
        }
    }
    
    func addTag(_ tag: FilterTag) {
        if !selectedTags.contains(tag) {
            selectedTags.append(tag)
        }
    }

    func clearSelection() {
        selectedTags.removeAll()
    }
}
