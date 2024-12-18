//
//  SectionData.swift
//  EMSwiftUI
//
//  Created by Halil Yavuz on 17.12.2024.
//

import Foundation

struct SectionData: Identifiable {
    let id = UUID()
    let title: String
    var tags: [SectionTag]
}

struct SectionTag: Identifiable {
    let id = UUID()
    let name: String
    var isSelected: Bool = false
}

extension SectionData {
    static let mockedSections: [SectionData] = [
        SectionData(title: "Content Rating", tags: [
            SectionTag(name: "General"),
            SectionTag(name: "Adults Only")
        ]),
        SectionData(title: "Publication Status", tags: [
            SectionTag(name: "Ongoing"),
            SectionTag(name: "Completed"),
            SectionTag(name: "Not Started")
        ]),
        SectionData(title: "Magazine Demographic", tags: [
            SectionTag(name: "Shounen"),
            SectionTag(name: "Shoujo"),
            SectionTag(name: "Seinen"),
            SectionTag(name: "Josei")
        ]),
        SectionData(title: "Format", tags: [
            SectionTag(name: "Webcomic"),
            SectionTag(name: "Manga"),
            SectionTag(name: "Light Novel")
        ]),
        SectionData(title: "Genre", tags: [
            SectionTag(name: "Action"),
            SectionTag(name: "Romance"),
            SectionTag(name: "Horror"),
            SectionTag(name: "Comedy")
        ]),
        SectionData(title: "Theme", tags: [
            SectionTag(name: "School Life"),
            SectionTag(name: "Fantasy"),
            SectionTag(name: "Sci-Fi"),
            SectionTag(name: "Slice of Life")
        ])
    ]
}


