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

enum StateVM {
    case initial
    case loading
    case success
    case error(Error)
}

protocol MangaListViewModel: ObservableObject {
    func getData() async
    var state: StateVM { get }
    var mangaList: [MangaData] { get }
    var mangaByEachCategory: [MangaCategory: [MangaData]] { get }
}

final class MangaListViewModelImpl: MangaListViewModel, ObservableObject {
    @Published var state: StateVM = .initial
    @Published var mangaList = [MangaData]()
    @Published var mangaByEachCategory: [MangaCategory: [MangaData]] = [:]
    
    private let service: MangaListService
    private let mangaCategories = MangaCategory.allCases
    
    init(service: MangaListService) {
        self.service = service
    }
    
    @MainActor func getData() async {
        state = .loading
        
        do {
            try await withThrowingTaskGroup(of: (MangaCategory, MangaListModel).self) { group in
                for category in mangaCategories {
                    group.addTask {
                        let response = try await self.service.getManga(category: category)
                        return (category, response)
                    }
                }
                
                for try await (category, response) in group {
                    mangaByEachCategory[category] = response.data
                }
            }
            state = .success
        } catch {
            state = .error(error)
        }
    }
}
