//
//  FilterMockData.swift
//  EMSwiftUI
//
//  Created by Максим Шишлов on 17.12.2024.
//

import Foundation

struct FilterMockData {
    static let sections: [FilterSection] = [
        FilterSection(title: "Content Rating", tags: [
            .init(name: "General"),
            .init(name: "Teen"),
            .init(name: "Mature"),
            .init(name: "Explicit")
        ]),
        FilterSection(title: "Publication Status", tags: [
            .init(name: "Ongoing"),
            .init(name: "Completed"),
            .init(name: "Hiatus"),
            .init(name: "Cancelled"),
            .init(name: "One-Shot")
        ]),
        FilterSection(title: "Genre", tags: [
            .init(name: "Action"),
            .init(name: "Adventure"),
            .init(name: "Comedy"),
            .init(name: "Drama"),
            .init(name: "Romance"),
            .init(name: "Mystery"),
            .init(name: "Horror")
        ]),
        FilterSection(title: "Magazine Demographic", tags: [
            .init(name: "Shonen"),
            .init(name: "Shojo"),
            .init(name: "Seinen"),
            .init(name: "Josei"),
            .init(name: "Kodomo")
        ]),
        FilterSection(title: "Format", tags: [
            .init(name: "Webcomic"),
            .init(name: "Manga"),
            .init(name: "Manhwa"),
            .init(name: "Manhua"),
            .init(name: "Light Novel"),
            .init(name: "Doujinshi")
        ]),
        FilterSection(title: "Theme", tags: [
            .init(name: "Fantasy"),
            .init(name: "Sci-Fi"),
            .init(name: "Slice of Life"),
            .init(name: "Psychological"),
            .init(name: "Historical"),
            .init(name: "Supernatural")
        ])
    ]
}
