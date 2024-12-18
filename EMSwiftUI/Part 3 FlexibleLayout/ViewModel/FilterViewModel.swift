//
//  FilterViewModel.swift
//  EMSwiftUI
//
//  Created by Halil Yavuz on 17.12.2024.
//

import Foundation

final class FilterViewModel: ObservableObject {
    
    @Published var sections: [SectionData] = SectionData.mockedSections
    @Published var selectedTags: [SectionTag] = []
    
    func addTag(_ tag: SectionTag) {
        guard !selectedTags.contains(where: { $0.id == tag.id }) else { return }
        selectedTags.append(tag)
    }
    
    func removeSelectedTag(_ tag: SectionTag) {
        selectedTags.removeAll { $0.id == tag.id }
    }
    
    func resetAllTags() {
        selectedTags.removeAll()
        for sectionIndex in sections.indices {
            for tagIndex in sections[sectionIndex].tags.indices {
                sections[sectionIndex].tags[tagIndex].isSelected = false
            }
        }
    }
    
    func toggleTagSelection(section: SectionData, tag: SectionTag) {
        // Находим индекс секции
        if let sectionIndex = sections.firstIndex(where: { $0.id == section.id }),
           // Находим индекс тега внутри секции
           let tagIndex = sections[sectionIndex].tags.firstIndex(where: { $0.id == tag.id }) {

            // Переключаем состояние выбранности тега
            sections[sectionIndex].tags[tagIndex].isSelected.toggle()
            let updatedTag = sections[sectionIndex].tags[tagIndex]

            // Добавляем или удаляем тег из списка выбранных
            if updatedTag.isSelected {
                addTag(updatedTag)
            } else {
                removeSelectedTag(updatedTag)
            }
        }
    }

}
