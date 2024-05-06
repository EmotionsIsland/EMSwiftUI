//
//  FiltersModel.swift
//  EMSwiftUI
//
//  Created by Alex on 6.05.24.
//

import Foundation

struct FiltersList {
    let contentRatings: [String]
    let publicationStatuses: [String]
    let magazineDemographics: [String]
    let formats: [String]
    let genres: [String]
    let themes: [String]
    init(contentRatings: Set<String>, publicationStatuses: Set<String>, magazineDemographics: Set<String>, formats: Set<String>, genres: Set<String>, themes: Set<String>) {
        self.contentRatings = contentRatings.sorted()
        self.publicationStatuses = publicationStatuses.sorted()
        self.magazineDemographics = magazineDemographics.sorted()
        self.formats = formats.sorted()
        self.genres = genres.sorted()
        self.themes = themes.sorted()
    }
}
