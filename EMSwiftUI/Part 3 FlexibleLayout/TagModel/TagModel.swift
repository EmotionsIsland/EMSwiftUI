//
//  TagModel.swift
//  EMSwiftUI
//
//  Created by Павел Градов on 11.03.2025.
//

import Foundation

class TagModel: ObservableObject {
    @Published var selectedTags: [String] = []
    
    let tags: [String: [String]] = [
        "Stars":
            [
                "Sirius", "Canopus", "Arcturus", "Alpha centauri", "Vega", "Capella", "Rigel", "Procyon", "Betelgeuse", "Altair"
            ],
        "Planets":
            [
                "Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"
            ],
        "Galaxies":
            [
                "Andromeda Galaxy", "Milky Way (Our home galaxy)", "Sombrero Galaxy", "Pinwheel Galaxy", "Black Eye Galaxy", "Cigar Galaxy", "Bode's Galaxy", "Cartwheel Galaxy", "Large Magellanic Cloud", "Small Magellanic Cloud"
            ],
        "Comets":
            [
                "Halley's Comet", "Comet Hale-Bopp", "Comet Hyakutake", "Comet Ikeya-Seki", "Comet McNaught", "Comet Bennett", "Comet Donati"
            ]
    ]
    
    func getTopic(_ topic: String) -> [String] {
        return tags[topic] ?? []
    }
    
    func addTag(_ tag: String) {
        if selectedTags.contains(tag) == false {
            selectedTags.append(tag)
        }
    }
    
    func removeTag(_ tag: String) {
        if let index = selectedTags.firstIndex(where: { $0 == tag} ) {
            selectedTags.remove(at: index)
        }
    }
    
    func removeAll() {
        selectedTags.removeAll()
    }
}
