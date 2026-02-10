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
    
    func getData() async
}

final class MangaListViewModelImpl: MangaListViewModel {
    @Published var items: [MangaData] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
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
            let response = try await service.getManga()
            items = response.data
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
