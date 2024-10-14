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
            updateTagSelectionState(tag: tag, isSelected: true)
        }
    }
    
    func resetSelectedTags() {
        selectedTags.removeAll()
        
        updateTagSelectionState(for: &genresTags, isSelected: false)
        updateTagSelectionState(for: &statusTags, isSelected: false)
        updateTagSelectionState(for: &formatTags, isSelected: false)
    }
    
    func removeTagFromSelected(_ tag: TagChipModel) {
        if let index = selectedTags.firstIndex(of: tag) {
            selectedTags.remove(at: index)
            updateTagSelectionState(tag: tag, isSelected: false)
        }
    }
    
    private func updateTagSelectionState(tag: TagChipModel, isSelected: Bool) {
        if let index = genresTags.firstIndex(of: tag) {
            genresTags[index].isSelected = isSelected
        }
        if let index = statusTags.firstIndex(of: tag) {
            statusTags[index].isSelected = isSelected
        }
        if let index = formatTags.firstIndex(of: tag) {
            formatTags[index].isSelected = isSelected
        }
    }
    
    private func updateTagSelectionState(for tags: inout [TagChipModel], isSelected: Bool) {
        for index in tags.indices {
            tags[index].isSelected = isSelected
        }
    }
}
