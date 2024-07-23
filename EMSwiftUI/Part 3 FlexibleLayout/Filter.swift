//
//  Filter.swift
//  EMSwiftUI
//
//  Created by Никита Гладышев on 21.07.2024.
//

import Foundation

class Filter: Hashable, Identifiable {
    
    let id = UUID()
    let name: String
    var isSelected: Bool
    
    init(name: String, isSelected: Bool) {
        self.name = name
        self.isSelected = isSelected
    }
    
    static func == (lhs: Filter, rhs: Filter) -> Bool {
        lhs.name == rhs.name && lhs.isSelected == rhs.isSelected && lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(isSelected)
        hasher.combine(id)
    }
}

extension Filter {
    static let mockData = [Filter(name: "Shounen", isSelected: false),
                           Filter(name: "Shoujo", isSelected: false),
                           Filter(name: "Sheinen", isSelected: false),
                           Filter(name: "Josei", isSelected: false),
                           Filter(name: "Nonse", isSelected: false),
                           Filter(name: "Search", isSelected: false),
                           Filter(name: "Very long filter", isSelected: false),
                           Filter(name: "Filter tt", isSelected: false),
                           Filter(name: "Another very long filter", isSelected: false),
                           Filter(name: "Note", isSelected: false)]
}
