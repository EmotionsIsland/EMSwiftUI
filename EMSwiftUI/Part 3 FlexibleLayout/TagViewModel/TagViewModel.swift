//
//  TagModel.swift
//  EMSwiftUI
//
//  Created by Павел Градов on 11.03.2025.
//

import Foundation

final class TagViewModel: ObservableObject {
    @Published private(set) var selectedTags: [TagStruct] = []
    @Published private(set) var tags: [String: [TagStruct]] = TagStruct.tags
    private var gridService = GridService()
    
    // MARK: - Internal access functions
    func manageButtonState(by buttonMode: ButtonMode, for title: String, _ tag: String) {
        switch buttonMode {
        case .unselected:
            addTag(by: title, tag: tag)
        case .selected:
            removeTag(by: title, tag: tag)
        }
        switchState(by: title, tag)
    }
    
    func removeAll() {
        selectedTags.removeAll()
        for (key, value) in tags {
            for tag in value {
                if tag.isSelected {
                    var tagToSwitch = tag
                    tagToSwitch.isSelected.toggle()
                    
                    let index = tags[key]?.firstIndex(where: { $0 == tag } ) ?? 0
                    tags[key]?[index] = tagToSwitch
                }
            }
        }
    }
    
    // MARK: - Callling grid service 
    func computeRows(
        by title: String,
        for gridViewMode: GridViewMode, _ tagsSize: [String: CGSize], _ availableWidthSpace: CGFloat
    ) -> [[String]] {
        
        let rowsData = gridService.getRowsData(
            by: title,
            for: gridViewMode, selectedTags, tags)
        
        let rowsStructure = gridService.computeRows(from: rowsData, for: tagsSize, availableWidthSpace)
        return rowsStructure
    }
    
    func getTitle(
        by tag: String, _ title: String,
        for gridViewMode: GridViewMode
    ) -> String {
        
        let title = gridService.getTitle(
            by: tag, title,
            for: gridViewMode, selectedTags
        )
        return title
    }
    
    func getButtonMode(
        by tag: String, _ title: String,
        for gridViewMode: GridViewMode
    ) -> ButtonMode {
        
        let buttonMode = gridService.getButtonMode(
            by: tag, title,
            for: gridViewMode, tags
        )
        return buttonMode
    }
    
    // MARK: - Private access functions
    private func addTag(by title: String, tag: String) {
        if selectedTags.contains(where: { $0.tag == tag }) == false {
            selectedTags.append(TagStruct(title: title, tag: tag, isSelected: true))
        }
    }
    
    private func removeTag(by title: String, tag: String) {
        if let index = selectedTags.firstIndex(where: { $0.tag == tag} ) {
            selectedTags.remove(at: index)
        }
    }
    
    private func switchState(by title: String, _ tag: String) {
        var tagToSwitch: TagStruct = tags[title]?.first(where: { $0.tag == tag } ) ?? TagStruct.defaultTag
        tagToSwitch.isSelected.toggle()
        
        let index = tags[title]?.firstIndex(where: { $0.tag == tag } ) ?? 0
        tags[title]?[index] = tagToSwitch
    }
}
