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
    var sections: [MangaSection] { get }
    var viewState: LoadState<[MangaSection]> { get }
    func onAppear()
    func retry()
}

final class MangaListViewModelImpl: MangaListViewModel {
    @Published private(set) var sections: [MangaSection] = []
    @Published private(set) var viewState: LoadState<[MangaSection]> = .loading
    private let service: MangaListService
    private var loadingTask: Task<Void, Never>?
    
    init(service: MangaListService) {
        self.service = service
    }
    
    func onAppear() {
        guard sections.isEmpty, loadingTask == nil else { return }
        loadData()
    }
    
    func retry() {
        loadData()
    }
    
    private func loadData() {
        loadingTask?.cancel()
        viewState = .loading
        
        loadingTask = Task {
            do {
                let response = try await service.getManga()
                let items = service.mapToSectionItems(from: response.data)
                let sections = [
                    MangaSection(title: "Popular", items: items),
                    MangaSection(title: "Recently Added", items: items),
                    MangaSection(title: "Last Updates", items: items)
                ]
                await MainActor.run {
                    self.sections = sections
                    self.viewState = .loaded(sections)
                    self.loadingTask = nil
                }
            } catch {
                await MainActor.run {
                    self.sections = []
                    self.viewState = .error(error.localizedDescription)
                    self.loadingTask = nil
                }
            }
        }
    }
}
