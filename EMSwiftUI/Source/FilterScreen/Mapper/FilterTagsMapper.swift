//
//  FilterTagsMapper.swift
//  EMSwiftUI
//
//  Created by Kseniya Semenova on 16.05.2026.
//

import Foundation

protocol FilterTagsMapper {
    func makeGroupedTags(from tags: [Tag]) -> [String: [FilterTagItem]]
}

struct FilterTagsMapperImpl: FilterTagsMapper {
    func makeGroupedTags(from tags: [Tag]) -> [String: [FilterTagItem]] {
        let items = tags.compactMap { tag -> FilterTagItem? in
            guard let title = tag.attributes.name.en else {
                return nil
            }

            return FilterTagItem(
                id: tag.id,
                title: title,
                group: tag.attributes.group
            )
        }

        return Dictionary(grouping: items, by: \.group)
            .mapValues { $0.sorted { $0.title < $1.title } }
    }
}
