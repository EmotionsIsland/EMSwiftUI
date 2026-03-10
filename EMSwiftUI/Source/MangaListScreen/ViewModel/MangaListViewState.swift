//
//  MangaListViewState.swift
//  EMSwiftUI
//
//  Created by Денис Ефименков on 10.03.2026.
//

import Foundation

enum MangaListViewState {
    case isLoading
    case isLoaded
    case failed(error: String)
}
