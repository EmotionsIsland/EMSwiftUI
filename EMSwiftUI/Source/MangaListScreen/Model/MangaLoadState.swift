//
//  MangaLoadState.swift
//  EMSwiftUI
//
//  Created by Новгородцев Никита on 29/07/2025.
//

import Foundation

enum MangaLoadState {
    case idle
    case loading
    case refreshing
    case loaded
    case failed(Error)
}

extension MangaLoadState: Equatable {
    static func == (lhs: MangaLoadState, rhs: MangaLoadState) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle),
             (.loading, .loading),
             (.refreshing, .refreshing),
             (.loaded, .loaded),
             (.failed, .failed):
            return true
        default:
            return false
        }
    }
}
