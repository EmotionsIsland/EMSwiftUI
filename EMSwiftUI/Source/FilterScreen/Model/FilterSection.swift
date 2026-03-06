//
//  FilterSection.swift
//  EMSwiftUI
//
//  Created by Денис Ефименков on 11.02.2026.
//

import Foundation

struct FilterSection: Identifiable, Hashable {
    let id: FilterTagGroup
    var isExpanded: Bool
    var tags: [FilterTag]

    var title: String { id.title }
}
