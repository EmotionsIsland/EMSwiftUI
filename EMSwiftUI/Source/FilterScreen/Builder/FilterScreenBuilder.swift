//
//  FilterScreenBuilder.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 17/3/25.
//

import SwiftUI
import Factory

final class FilterScreenBuilder {
    static func build() -> some View {
        let service: FilterTagsService = FilterTagsServiceImpl(netify: Container.shared.netify())
        let viewModel = FilterTagsViewModelImpl(service: service)
        return FilterScreen(viewModel: viewModel)
    }
}
