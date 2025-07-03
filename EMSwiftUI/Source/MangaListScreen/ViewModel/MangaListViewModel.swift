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
    var mangaList: [MangaData] { get }
    var isLoading: Bool { get }
    var error: String? { get }
    func getData() async throws
    func getCover(for manga: MangaData) -> URL?
    func rating(for manga: MangaData) -> Double
}

final class MangaListViewModelImpl: MangaListViewModel {
    @Published private(set) var mangaList: [MangaData] = []
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var error: String?
    
    private let service: MangaListService
    
    init(service: MangaListService) {
        self.service = service
    }
    
    func getData() async throws {
        await MainActor.run {
            isLoading = true
            error = nil
        }
        
        do {
            let result = try await service.getManga()
            await MainActor.run {
                mangaList = result.data
            }
        } catch {
            print("*** Error in \(#function): \(error)")
        }
        
        await MainActor.run {
            isLoading = false
        }
    }
    
    func getCover(for manga: MangaData) -> URL? {
        API.coverURL(for: manga, .size512)
    }
    
    func rating(for manga: MangaData) -> Double {
        return Double.random(in: 0...5)
    }
}
