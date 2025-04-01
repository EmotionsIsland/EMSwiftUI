//
//  FilterViewModel.swift
//  EMSwiftUI
//
//  Created by Антон Баландин on 1.04.25.
//

import Foundation

protocol FilterScreenViewMode: ObservableObject {
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    var mangaTitle: [String] { get }
    
    func getData() async throws
}

class FilterScreenViewModelImpl: FilterScreenViewMode {
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var tagsList: [String: [String]] = [:]
    
    var mangaTitle = ["Content Rating", "Publication Status", "Magazine Demographic", "Format", "Genre", "Theme"]
    
    private let service: MangaListService
    
    init(service: MangaListService) {
        self.service = service
    }
    
    @MainActor
        func getData() async throws {
            isLoading = true
            errorMessage = nil
            
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
                
                tagsList = [
                    "Content Rating": uniqueRatings,
                    "Publication Status": uniqueStatuses,
                    "Magazine Demographic": uniqueDemographics,
                    "Format": uniqueFormats,
                    "Genre": uniqueGenres,
                    "Theme": uniqueThemes
                ]
                
                print("Tags list:", tagsList)
            } catch {
                errorMessage = error.localizedDescription
                print("Error fetching data:", error)
            }
            
            isLoading = false
        }
}
