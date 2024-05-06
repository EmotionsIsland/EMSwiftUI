//
//  FiltersViewModel.swift
//  EMSwiftUI
//
//  Created by Alex on 6.05.24.
//

import Foundation


@MainActor
final class FiltersViewModel: ObservableObject {
    @Published var filtersList: FiltersList?
    @Published var state: DataState = .notAvailable
    
    var hasError: Bool {
        switch state {
        case .successfull:
            false
        case .failed(_):
            true
        case .notAvailable:
            false
        }
    }
    
    private var service: MangaListServiceProtocol
    
    init(service: MangaListServiceProtocol) {
        self.service = service
        getFilters()
    }
    
    func getFilters() {
        Task {
            let fetchTask = Task.detached(priority: .background) {
                let filters = try await self.service.getFilters()
                return filters
            }
            do {
                self.filtersList = try await fetchTask.value
                self.state = .successfull
            } catch {
                self.state = .failed(error: error)
            }
        }
    }
}
