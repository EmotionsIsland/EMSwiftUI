//
//  TagGroupMapper.swift
//  EMSwiftUI
//
//  Created by Дарья Саитова on 28.05.2026.
//

import Foundation

protocol TagGroupMapper {
    func groupTags(_ tags: [TagDTO]) -> [String: [FilterChipItem]]
}

struct TagGroupMapperImpl: TagGroupMapper {
    func groupTags(_ tags: [TagDTO]) -> [String: [FilterChipItem]] {
        let items = tags.compactMap { tag -> FilterChipItem? in
            let name = tag.attributes.name.displayValue
            guard !name.isEmpty else { return nil }
            return FilterChipItem(
                id: tag.id,
                title: name,
                group: tag.attributes.group
            )
        }
        return Dictionary(grouping: items, by: \.group)
            .mapValues { $0.sorted { $0.title < $1.title } }
    }
}
