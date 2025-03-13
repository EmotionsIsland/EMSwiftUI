//
//  TagModel.swift
//  EMSwiftUI
//
//  Created by Павел Градов on 11.03.2025.
//

import Foundation

final class TagViewModel: ObservableObject {
    final class TagClass {
        let tag: String
        var isSelected: Bool = false
        
        init(tag: String) {
            self.tag = tag
        }
        
        func toggleSelection() {
            isSelected.toggle()
        }
    }
    
    struct SelectedTag {
        let title: String
        let tag: String
    }
    
    @Published var selectedTags: [SelectedTag] = []
    @Published var tags: [String: [TagClass]] = [
        "Stars": [
            TagClass(tag: "Sirius"),
            TagClass(tag: "Canopus"),
            TagClass(tag: "Arcturus"),
            TagClass(tag: "Alpha centauri"),
            TagClass(tag: "Vega"),
            TagClass(tag: "Capella"),
            TagClass(tag: "Rigel"),
            TagClass(tag: "Procyon"),
            TagClass(tag: "Betelgeuse"),
            TagClass(tag: "Altair")
        ],
        "Planets": [
            TagClass(tag: "Mercury"),
            TagClass(tag: "Venus"),
            TagClass(tag: "Earth"),
            TagClass(tag: "Mars"),
            TagClass(tag: "Jupiter"),
            TagClass(tag: "Saturn"),
            TagClass(tag: "Uranus"),
            TagClass(tag: "Neptune")
        ],
        "Galaxies": [
            TagClass(tag: "Andromeda Galaxy"),
            TagClass(tag: "Milky Way (Our home galaxy)"),
            TagClass(tag: "Sombrero Galaxy"),
            TagClass(tag: "Pinwheel Galaxy"),
            TagClass(tag: "Black Eye Galaxy"),
            TagClass(tag: "Cigar Galaxy"),
            TagClass(tag: "Bode's Galaxy"),
            TagClass(tag: "Cartwheel Galaxy"),
            TagClass(tag: "Large Magellanic Cloud"),
            TagClass(tag: "Small Magellanic Cloud"),
        ],
        "Comets": [
            TagClass(tag: "Halley's Comet"),
            TagClass(tag: "Comet Hale-Bopp"),
            TagClass(tag: "Comet Hyakutake"),
            TagClass(tag: "Comet Ikeya-Seki"),
            TagClass(tag: "Comet McNaught"),
            TagClass(tag: "Comet Bennett"),
            TagClass(tag: "Comet Donati"),
        ]
    ]
    
    func addTag(by title: String, tag: String) {
        if selectedTags.contains(where: { $0.tag == tag }) == false {
            selectedTags.append(SelectedTag(title: title, tag: tag))
            print(title, tag)
        }
    }
    
    func removeTag(by title: String, tag: String) {
        if let index = selectedTags.firstIndex(where: { $0.tag == tag} ) {
            selectedTags.remove(at: index)
        }
    }
    
    func removeAll() {
        selectedTags.removeAll()
        for value in tags.values {
            for tag in value {
                tag.isSelected = false
            }
        }
    }
    
    func switchState(by title: String, _ tag: String) {
        tags[title]?.first(where: { $0.tag == tag })?.toggleSelection()
    }
}
