//
//  MangaListScreenBuilder.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 17/3/25.
//

import SwiftUI
import Factory

final class MangaListScreenBuilder {
    static func build(searchText: Binding<String>) -> some View {
        let service: MangaListService = MangaListServiceImpl(netify: Container.shared.netify())
        let viewModel = MangaListViewModelImpl(service: service)
        let view = MangaListScreen(viewModel: viewModel, searchText: searchText)
        
        return view
    }
}
