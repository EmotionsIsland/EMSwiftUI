//
//  FilterViewModel.swift
//  EMSwiftUI
//
//  Created by Иван Незговоров on 10.12.2024.
//

import SwiftUI

final class FilterViewModel: ObservableObject {
    @Published var selectedTags: [SelectedTag] = []
    
    @Published var sections: [(text: String, isSelect: [SelectedTag])] = FilterData.predefinedSections
    
    func addTag(_ tag: SelectedTag, needDeletePlus: Bool) {
        if !selectedTags.contains(where: { $0.id == tag.id }) {
            selectedTags.append(tag)
            changeSelectTagForSection(isChange: true, tag: tag, needDeletePlus: needDeletePlus)
        }
    }
    
    func removeTag(_ tag: SelectedTag, needDeletePlus: Bool) {
        selectedTags.removeAll { $0.id == tag.id }
        changeSelectTagForSection(isChange: false, tag: tag, needDeletePlus: needDeletePlus)
    }
    
    func removeAllTags() {
        selectedTags.removeAll()
        for sectionIndex in sections.indices {
            for tagIndex in sections[sectionIndex].isSelect.indices {
                sections[sectionIndex].isSelect[tagIndex].select = false
                if sections[sectionIndex].isSelect[tagIndex].text.prefix(2) == "+ " {
                    sections[sectionIndex].isSelect[tagIndex].text.removeFirst(2)
                }
            }
        }
    }
    
    private func changeSelectTagForSection(isChange: Bool, tag: SelectedTag, needDeletePlus: Bool) {
        for sectionIndex in sections.indices {
            if let tagIndex = sections[sectionIndex].isSelect.firstIndex(where: { $0.id == tag.id }) {
                sections[sectionIndex].isSelect[tagIndex].select = isChange
                if needDeletePlus {
                    sections[sectionIndex].isSelect[tagIndex].text.removeFirst(2)
                }
            }
        }
    }
    
    func saveTags() {
        print("save tags")
    }
}
