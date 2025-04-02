//
//  MangaListViewModel.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import Foundation
import UIKit
import Netify
import OSLog

enum SizeFormat: String {
    case size256 = ".256.jpg"
    case size512 = ".512.jpg"
    case size1024 = ".1024.jpg"
}

protocol MangaListViewModel: ObservableObject {
    var items: [MangaListItem] { get }

    @MainActor
    func fetchItems() async

    @MainActor
    func fetchCover(for item: MangaListItem) async -> UIImage?
}

final class MangaListViewModelImpl: MangaListViewModel {
    @Published var items: [MangaListItem] = []

    private let service: MangaListService

    init(service: MangaListService) {
        self.service = service
    }
    
    @MainActor
    func fetchItems() async {
        do {
            items = try await service.fetchManga().data
                .map(MangaListItem.init)
        } catch {
            Logger.standard.error("\(error)")
        }
    }

    @MainActor
    func fetchCover(for item: MangaListItem) async -> UIImage? {
        do {
            return try await service.fetchCover(for: item)
        } catch {
            Logger.standard.error("\(error)")
        }

        return nil
    }
}
