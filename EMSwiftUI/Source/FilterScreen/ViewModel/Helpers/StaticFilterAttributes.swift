//
//  StaticFilterAttributes.swift
//  EMSwiftUI
//
//  Created by Денис Ефименков on 25.02.2026.
//

import Foundation

protocol StaticFilterAttributesProtocol {
    var staticTags: [FilterTag] { get }
    var staticSections: [FilterSection] { get }
    var apiOrder: [FilterTagGroup] { get }
}

struct StaticFilterAttributes: StaticFilterAttributesProtocol {
    var staticTags: [FilterTag] {
        contentRatingTags + publicationDemographicTags + statusTags
    }

    var staticSections: [FilterSection] {
        [
            FilterSection(id: .contentRating, isExpanded: false, tags: contentRatingTags),
            FilterSection(id: .publicationDemographic, isExpanded: false, tags: publicationDemographicTags),
            FilterSection(id: .status, isExpanded: false, tags: statusTags)
        ]
    }

    var apiOrder: [FilterTagGroup] { [.format, .genre, .theme] }

    // MARK: - Static tags

    private var contentRatingTags: [FilterTag] {
        makeTags(prefix: "contentRating", group: .contentRating, values: [
            ("safe", "Safe"),
            ("suggestive", "Suggestive"),
            ("erotica", "Erotica"),
            ("pornographic", "Pornographic")
        ])
    }

    private var publicationDemographicTags: [FilterTag] {
        makeTags(prefix: "publicationDemographic", group: .publicationDemographic, values: [
            ("shounen", "Shounen"),
            ("shoujo", "Shoujo"),
            ("seinen", "Seinen"),
            ("josei", "Josei")
        ])
    }

    private var statusTags: [FilterTag] {
        makeTags(prefix: "status", group: .status, values: [
            ("ongoing", "Ongoing"),
            ("completed", "Completed"),
            ("hiatus", "Hiatus"),
            ("cancelled", "Cancelled")
        ])
    }

    private func makeTags(
        prefix: String,
        group: FilterTagGroup,
        values: [(value: String, title: String)]
    ) -> [FilterTag] {
        values.map { item in
            FilterTag(
                id: "\(prefix):\(item.value)",
                title: item.title,
                group: group
            )
        }
    }
}
