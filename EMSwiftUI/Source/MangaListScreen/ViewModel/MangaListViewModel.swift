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

@MainActor
protocol MangaListViewModel: ObservableObject {
    var items: [MangaData] { get }
    var screenState: MangaListViewState { get }
    
    var popularVM: [MangaGridItemViewModel] { get }
    var recentlyAddedVM: [MangaGridItemViewModel] { get }
    var lastUpdatesVM: [MangaGridItemViewModel] { get }
    
    func getData() async
}

@MainActor
final class MangaListViewModelImpl: MangaListViewModel {
    @Published var items: [MangaData] = []
    @Published var screenState: MangaListViewState = .isLoading

    @Published var popularVM: [MangaGridItemViewModel] = []
    @Published var recentlyAddedVM: [MangaGridItemViewModel] = []
    @Published var lastUpdatesVM: [MangaGridItemViewModel] = []

    private let service: MangaListService

    init(service: MangaListService) {
        self.service = service
    }

    func getData() async {
        do {
            async let popularResponse = service.getManga(sort: .popular)
            async let recentlyAddedResponse = service.getManga(sort: .recentlyAdded)
            async let lastUpdatesResponse = service.getManga(sort: .lastUpdates)

            let (popularModel, recentlyAddedModel, lastUpdatesModel) = try await (popularResponse, recentlyAddedResponse, lastUpdatesResponse)

            popularVM = popularModel.data.map { MangaGridItemViewModel(manga: $0) }
            recentlyAddedVM = recentlyAddedModel.data.map { MangaGridItemViewModel(manga: $0) }
            lastUpdatesVM = lastUpdatesModel.data.map { MangaGridItemViewModel(manga: $0) }

            screenState = .isLoaded
        } catch {
            screenState = .failed(error: error.localizedDescription)
        }
    }
}
