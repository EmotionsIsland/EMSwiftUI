//
//  FilterViewModel.swift
//  EMSwiftUI
//
//  Created by Алсу Хайруллина on 14.10.2024.
//

import Foundation

final class FilterViewModel: ObservableObject {
    
    @Published var selectedTags: [TagChipModel] = []
    
    @Published var genresTags: [TagChipModel] = TagChipModel.mockGenreTags
    @Published var statusTags: [TagChipModel] = TagChipModel.mockPulicationStatusTags
    @Published var formatTags: [TagChipModel] = TagChipModel.mockFormatTags
    
    func addTagToSelected(_ tag: TagChipModel) {
        if !selectedTags.contains(tag) {
            selectedTags.append(tag)
            updateTagSelectionState(for: [tag], isSelected: true)
        }
    }
    
    func resetSelectedTags() {
        selectedTags.removeAll()
        updateTagSelectionState(for: genresTags + statusTags + formatTags, isSelected: false)
    }
    
    func removeTagFromSelected(_ tag: TagChipModel) {
        if let index = selectedTags.firstIndex(of: tag) {
            selectedTags.remove(at: index)
            updateTagSelectionState(for: [tag], isSelected: false)
        }
    }
    
    private func updateTagSelectionState(for tags: [TagChipModel], isSelected: Bool) {
        updateTags(&genresTags, for: tags, isSelected: isSelected)
        updateTags(&statusTags, for: tags, isSelected: isSelected)
        updateTags(&formatTags, for: tags, isSelected: isSelected)
    }
    
    private func updateTags(_ sourceTags: inout [TagChipModel], for tags: [TagChipModel], isSelected: Bool) {
        for tag in tags {
            if let index = sourceTags.firstIndex(of: tag) {
                sourceTags[index].isSelected = isSelected
            }
        }
    }
}

