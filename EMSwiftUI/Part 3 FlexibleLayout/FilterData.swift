//
//  FilterData.swift
//  EMSwiftUI
//
//  Created by Иван Незговоров on 17.12.2024.
//


struct FilterData {
    static let predefinedSections: [(text: String, isSelect: [SelectedTag])] = [
        ("Content Rating", [
            SelectedTag(text: "G", select: false),
            SelectedTag(text: "PG", select: false),
            SelectedTag(text: "PG-13", select: false),
            SelectedTag(text: "R", select: false)
        ]),
        ("Publication Status", [
            SelectedTag(text: "Published", select: false),
            SelectedTag(text: "Draft", select: false),
            SelectedTag(text: "Pending", select: false)
        ]),
        ("Magazine Demographic", [
            SelectedTag(text: "Teens", select: false),
            SelectedTag(text: "Adults", select: false),
            SelectedTag(text: "Seniors", select: false)
        ]),
        ("Format", [
            SelectedTag(text: "Print", select: false),
            SelectedTag(text: "Digital", select: false),
            SelectedTag(text: "Hybrid", select: false)
        ]),
        ("Genre", [
            SelectedTag(text: "Fiction", select: false),
            SelectedTag(text: "Non-fiction", select: false),
            SelectedTag(text: "Poetry", select: false),
            SelectedTag(text: "Biography", select: false)
        ]),
        ("Theme", [
            SelectedTag(text: "Love", select: false),
            SelectedTag(text: "Adventure", select: false),
            SelectedTag(text: "Family", select: false),
            SelectedTag(text: "Mystery", select: false)
        ])
    ]
}
