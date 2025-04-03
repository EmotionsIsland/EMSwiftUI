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
            async let tagsResponse = service.getTags()
            async let mangaResponse = service.getManga()
            
            let (tags, manga) = try await (tagsResponse, mangaResponse)
            
            tagDictionary = processData(tags: tags.data, manga: manga.data)
        } catch {
            print("Error loading data: \(error.localizedDescription)")
        }
    }
    
    private func processData(tags: [Tag], manga: [MangaData]) -> [String: [String]] {
        let uniqueRatings = Set(manga.map { $0.attributes.contentRating }).sorted()
        let uniqueStatuses = Set(manga.map { $0.attributes.status }).sorted()
        let uniqueDemographics = Set(manga.compactMap { $0.attributes.publicationDemographic }).sorted()
        
        let groupedTags = Dictionary(grouping: tags) { $0.attributes.group }
        
        let formatTags = extractTagNames(from: groupedTags["format"] ?? [])
        let genreTags = extractTagNames(from: groupedTags["genre"] ?? [])
        let themeTags = extractTagNames(from: groupedTags["theme"] ?? [])
        
        return [
            Strings.contentRating: uniqueRatings,
            Strings.publicationStatus: uniqueStatuses,
            Strings.magazineDemographic: uniqueDemographics,
            Strings.format: formatTags,
            Strings.genre: genreTags,
            Strings.theme: themeTags
        ]
    }
    
    private func extractTagNames(from tags: [Tag]) -> [String] {
        tags.compactMap { $0.attributes.name.en }.sorted()
    }
}
