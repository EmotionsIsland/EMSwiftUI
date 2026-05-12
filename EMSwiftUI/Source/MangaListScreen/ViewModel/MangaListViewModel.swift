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

enum MangaListViewState: Equatable {
    case loading
    case content
    case error(String)
}

protocol MangaListViewModel: ObservableObject {
    var sections: [MangaSection] { get }
    var viewState: MangaListViewState { get }

    func onAppear()
    func retry()
}

final class MangaListViewModelImpl: MangaListViewModel {
    @Published private(set) var sections: [MangaSection] = []
    @Published private(set) var viewState: MangaListViewState = .loading

    private let service: MangaListService
    private var isFetching = false

    init(service: MangaListService) {
        self.service = service
    }

    func onAppear() {
        guard sections.isEmpty, !isFetching else { return }
        loadData()
    }
    func retry() {
        loadData()
    }
}
private extension MangaListViewModelImpl {
    func loadData() {
        guard !isFetching else { return }
        isFetching = true
        viewState = .loading
        Task { [self] in
            do {
                let response = try await service.getManga()
                let sections = self.makeSections(from: response.data)
                await MainActor.run {
                    self.isFetching = false
                    self.sections = sections
                    self.viewState = .content
                }
            } catch {
                await MainActor.run {
                    self.isFetching = false
                    self.sections = []
                    self.viewState = .error(error.localizedDescription)
                }
            }
        }
    }

    func makeSections(from data: [MangaData]) -> [MangaSection] {
        let items = service.getSectionItems(from: data)

        return [
            MangaSection(title: "Popular", items: items),
            MangaSection(title: "Recently Added", items: items),
            MangaSection(title: "Last Updates", items: items)
        ]
    }
}
