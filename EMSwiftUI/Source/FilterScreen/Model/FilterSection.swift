//
//  FilterSection.swift
//  EMSwiftUI
//
//  Created by Денис Ефименков on 11.02.2026.
//

import Foundation

struct FilterSection: Hashable {
    let filterTagGroup: FilterTagGroup
    var isExpanded: Bool
    var tags: [FilterTag]

    var title: String { filterTagGroup.title }
}
