//
//  FilterViewModel.swift
//  EMSwiftUI
//
//  Created by Иван Незговоров on 10.12.2024.
//

import SwiftUI

class FilterViewModel: ObservableObject {
    @Published var selectedTags: [SelectedTag] = []
    
    @Published var sections: [(String, [SelectedTag])] = [
        ("Content Rating", [
            SelectedTag(text: "G", select: false),
            SelectedTag(text: "PG", select: false),
            SelectedTag(text: "PG-13", select: false),
            SelectedTag(text: "R", select: false)
        ]),
        ("Publication Status", [
            SelectedTag(text: "Published", select: false),
            SelectedTag(text: "Draft", select: false),
            SelectedTag(text: "Pending", select: false)
        ]),
        ("Magazine Demographic", [
            SelectedTag(text: "Teens", select: false),
            SelectedTag(text: "Adults", select: false),
            SelectedTag(text: "Seniors", select: false)
        ]),
        ("Format", [
            SelectedTag(text: "Print", select: false),
            SelectedTag(text: "Digital", select: false),
            SelectedTag(text: "Hybrid", select: false)
        ]),
        ("Genre", [
            SelectedTag(text: "Fiction", select: false),
            SelectedTag(text: "Non-fiction", select: false),
            SelectedTag(text: "Poetry", select: false),
            SelectedTag(text: "Biography", select: false)
        ]),
        ("Theme", [
            SelectedTag(text: "Love", select: false),
            SelectedTag(text: "Adventure", select: false),
            SelectedTag(text: "Family", select: false),
            SelectedTag(text: "Mystery", select: false)
        ])
    ]
    
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
            for tagIndex in sections[sectionIndex].1.indices {
                sections[sectionIndex].1[tagIndex].select = false
                if sections[sectionIndex].1[tagIndex].text.prefix(2) == "+ " {
                    sections[sectionIndex].1[tagIndex].text.removeFirst(2)
                }
            }
        }
    }
    
    private func changeSelectTagForSection(isChange: Bool, tag: SelectedTag, needDeletePlus: Bool) {
        for sectionIndex in sections.indices {
            if let tagIndex = sections[sectionIndex].1.firstIndex(where: { $0.id == tag.id }) {
                sections[sectionIndex].1[tagIndex].select = isChange
                if needDeletePlus {
                    sections[sectionIndex].1[tagIndex].text.removeFirst(2)
                }
            }
        }
    }
    
    func saveTags() {
        print("save tags")
    }
}
