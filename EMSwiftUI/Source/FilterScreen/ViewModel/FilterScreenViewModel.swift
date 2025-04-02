//
//  FilterScreenViewModel.swift
//  EMSwiftUI
//
//  Created by Антон Баландин on 1.04.25.
//

import Foundation

protocol FilterScreenViewModel: ObservableObject {
    var mangaTitle: [String] { get }
    var filters: [String: [String]] { get }
    var pickedFilters: Set<String> { get set }
    
    func removeAllFilters()
    func pickFilter(_ filter: String)
    func checkPicking(_ filter: String) -> Bool
}

class FilterScreenViewModelImpl: FilterScreenViewModel {
    @Published var filters: [String: [String]] = [:]
    @Published var pickedFilters: Set<String> = []
    
    var mangaTitle = ["Content Rating", "Publication Status", "Magazine Demographic", "Format", "Genre", "Theme"]
    
    private let service: MangaListService
    
    init(service: MangaListService) {
        self.service = service
        loadInitialData()
    }
    
    @MainActor
    func getData() async {
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
            
            filters = [
                "Content Rating": uniqueRatings,
                "Publication Status": uniqueStatuses,
                "Magazine Demographic": uniqueDemographics,
                "Format": uniqueFormats,
                "Genre": uniqueGenres,
                "Theme": uniqueThemes
            ]
            
            print("Tags list:", filters)
        } catch {
            print("Error fetching data:", error.localizedDescription)
        }
    }
    
    func pickFilter(_ filter: String) {
        pickedFilters.insert(filter)
    }
    
    func checkPicking(_ filter: String) -> Bool {
        return pickedFilters.contains(filter)
    }
    
    func removeAllFilters() {
        pickedFilters.removeAll()
    }
    
    private func loadInitialData() {
        Task {
            await getData()
        }
    }
}
