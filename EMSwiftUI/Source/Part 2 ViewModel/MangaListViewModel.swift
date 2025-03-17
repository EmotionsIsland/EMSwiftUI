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

final class MangaListViewModel: ObservableObject {
    // TODO: create Published variables
    // TODO: create getData func
    private let service: MangaListService

    init(service: MangaListService) {
        self.service = service
    }
    
    @MainActor private func getData() async throws { }
}
