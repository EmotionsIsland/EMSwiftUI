//
//  MangaListViewModel.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import Foundation
import Netify
import Combine

enum SizeFormat: String {
    case size256 = ".256.jpg"
    case size512 = ".512.jpg"
    case size1024 = ".1024.jpg"
}

protocol MangaSectionProtocol: AnyObject {
    func getCoverURL(mangaData: MangaData, sizeFormat: SizeFormat) -> URL?
}

protocol MangaListViewModel: AnyObject, ObservableObject, MangaSectionProtocol {
    var filteredMangaDataBySection: [MangaSectionType: [MangaData]] { get }
    var visibleSections: [MangaSectionType] { get }
    var viewState: ViewState { get }
    func getData() async
}

final class MangaListViewModelImpl: MangaListViewModel {
    // MARK: Publishers
    @Published var mangaData: [MangaData] = []
    @Published var filteredMangaDataBySection: [MangaSectionType: [MangaData]] = [:]
    @Published var viewState: ViewState = .idle
    
    // MARK: Properties
    private let service: MangaListService
    private var sections: [MangaSectionType] = [.popular, .recentlyAdded, .lastUpdates, .seasonal]
    private var cancellables = Set<AnyCancellable>()
    var visibleSections: [MangaSectionType] {
        filteredMangaDataBySection
            .filter { !$0.value.isEmpty }
            .map { $0.key }
    }
    
    // MARK: Initialization
    init(service: MangaListService) {
        self.service = service
        setupFiltering()
    }
}

// MARK: - Private Methods
extension MangaListViewModelImpl {
    private func setupFiltering() {
        $mangaData
            .map { list in
                self.sections.reduce(into: [MangaSectionType: [MangaData]]()) { result, section in
                    let filtered = section.filter(list: list, using: self)
                    if !filtered.isEmpty {
                        result[section] = filtered
                    }
                }
            }
            .assign(to: \.filteredMangaDataBySection, on: self)
            .store(in: &cancellables)
    }
}

// MARK: - Network
extension MangaListViewModelImpl {
    @MainActor func getData() async {
        viewState = .loading
        do {
            self.mangaData = try await service.getManga().data
            viewState = .success
        } catch {
            viewState = .error(error.localizedDescription)
        }
    }
    
    func getCoverURL(mangaData: MangaData, sizeFormat: SizeFormat) -> URL? {
        API.coverURL(for: mangaData, sizeFormat)
    }
}

// MARK: - Season Filtering
extension MangaListViewModelImpl {
    func isDateIsCurrentSeason(dateString: String) -> Bool {
        guard let date = ISO8601DateFormatter().date(from: dateString) else { return false }
        let now = Date()
        guard Calendar.current.component(.year, from: date) == Calendar.current.component(.year, from: now) else {
                return false
            }
        let season = { (date: Date) -> Int in
            switch Calendar.current.component(.month, from: date) {
            case 3...5: return 1
            case 6...8: return 2
            case 9...11: return 3
            default: return 4
            }
        }
        return season(date) == season(now)
    }
}
