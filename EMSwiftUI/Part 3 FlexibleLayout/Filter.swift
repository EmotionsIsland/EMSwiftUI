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
