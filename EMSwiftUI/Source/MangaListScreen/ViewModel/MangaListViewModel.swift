//
//  MangaListViewModel.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import Foundation
import Netify

enum SizeFormat: String {
    case size256 = ".256.jpg"
    case size512 = ".512.jpg"
    case size1024 = ".1024.jpg"
}

protocol MangaListViewModel: ObservableObject {
    var items: [MangaData] { get }
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    var popular: [MangaData] { get }
    var recentlyAdded: [MangaData] { get }
    var lastUpdates: [MangaData] { get }
    
    func getData() async
}

final class MangaListViewModelImpl: MangaListViewModel {
    @Published var items: [MangaData] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published private(set) var popular: [MangaData] = []
    @Published private(set) var recentlyAdded: [MangaData] = []
    @Published private(set) var lastUpdates: [MangaData] = []
    
    private let service: MangaListService

    init(service: MangaListService) {
        self.service = service
    }
    
    @MainActor func getData() async {
        guard !isLoading else { return }
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        do {
            async let popularResponse = service.getManga(sort: .popular)
            async let recentlyAddedResponse = service.getManga(sort: .recentlyAdded)
            async let lastUpdatesResponse = service.getManga(sort: .lastUpdates)

            let (popularModel, recentlyAddedModel, lastUpdatesModel) = try await (popularResponse, recentlyAddedResponse, lastUpdatesResponse)

            popular = popularModel.data
            recentlyAdded = recentlyAddedModel.data
            lastUpdates = lastUpdatesModel.data
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
