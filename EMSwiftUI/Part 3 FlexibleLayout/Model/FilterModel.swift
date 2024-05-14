//
//  FilterModel.swift
//  EMSwiftUI
//
//  Created by User on 14.05.2024.
//

import Foundation

struct Filter: Identifiable, Hashable {
    let id = UUID()
    let name: String
}

extension Filter {
    static let allFilters: [Filter] = [
        Filter(name: "Filter 1"),
        Filter(name: "Filter 2"),
        Filter(name: "Filter 3scdcsafefdfvsdcs"),
        Filter(name: "Filter 4"),
        Filter(name: "Filter 5"),
        Filter(name: "Filter 6"),
        Filter(name: "Filter 7"),
        Filter(name: "Filter 8"),
        Filter(name: "Filter 9csc"),
        Filter(name: "Filter 10"),
        Filter(name: "Filter 11"),
        Filter(name: "Filter asc12"),
        Filter(name: "Filter 13"),
        Filter(name: "Filter 14"),
        Filter(name: "Filter 15"),
        Filter(name: "Filter 16"),
        Filter(name: "Filter 17"),
        Filter(name: "Filter 18zz"),
        Filter(name: "Filter 19"),
        Filter(name: "Filter 20")
    ]
}
