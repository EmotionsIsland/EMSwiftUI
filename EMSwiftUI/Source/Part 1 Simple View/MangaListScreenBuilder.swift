//
//  MangaListScreenBuilder.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 17/3/25.
//

import SwiftUI

final class MangaListScreenBuilder {
    static func build() -> some View {
        let service = MangaListServiceImpl(container: .shared)
        let viewModel = MangaListViewModel(service: service)
        let view = MangaListScreen(viewModel: viewModel)
        
        return view
    }
}
