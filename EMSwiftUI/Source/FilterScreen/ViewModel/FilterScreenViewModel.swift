//
//  FilterScreenViewModel.swift
//  EMSwiftUI
//
//  Created by Антон Баландин on 1.04.25.
//

import Foundation

protocol FilterScreenViewModel: ObservableObject {
    var tagDictionary: [String: [String]] { get }
    var selectedTags: Set<String> { get }
    
    func removeAllSelectedTags()
    func addTag(_ tag: String)
    func isSelected(_ tag: String) -> Bool
}

class FilterScreenViewModelImpl: FilterScreenViewModel {
    @Published private(set) var selectedTags: Set<String> = []
    @Published private(set) var tagDictionary: [String: [String]] = [:]
    
    private let service: MangaListService
    
    init(service: MangaListService) {
        self.service = service
        loadInitialData()
    }
    
    func addTag(_ tag: String) {
        selectedTags.insert(tag)
    }
    
    func isSelected(_ tag: String) -> Bool {
        return selectedTags.contains(tag)
    }
    
    func removeAllSelectedTags() {
        selectedTags.removeAll()
    }
    
    private func loadInitialData() {
        Task {
            await getData()
        }
    }
    
    @MainActor
    private func getData() async {
        do {
            let tags = try await service.getTags()
            let mangaResponse = try await service.getManga()
            let allManga = mangaResponse.data
            
            let uniqueRatings = Array(Set(allManga.map { $0.attributes.contentRating })).sorted()
            let uniqueStatuses = Array(Set(allManga.map { $0.attributes.status })).sorted()
            let uniqueDemographics = Array(Set(allManga.compactMap { $0.attributes.publicationDemographic })).sorted()
            
            let uniqueFormats = Array(Set(tags
                .filter { $0.attributes.group == "format" }
                .compactMap { $0.attributes.name.en }))
                .sorted()
            
            let uniqueGenres = Array(Set(tags
                .filter { $0.attributes.group == "genre" }
                .compactMap { $0.attributes.name.en }))
                .sorted()
            
            let uniqueThemes = Array(Set(tags
                .filter { $0.attributes.group == "theme" }
                .compactMap { $0.attributes.name.en }))
                .sorted()
            
            tagDictionary = [
                Strings.contentRating: uniqueRatings,
                Strings.publicationStatus: uniqueStatuses,
                Strings.magazineDemographic: uniqueDemographics,
                Strings.format: uniqueFormats,
                Strings.genre: uniqueGenres,
                Strings.theme: uniqueThemes
            ]
        } catch {}
    }
}
