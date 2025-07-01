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
        let service = TagServiceImpl(netify: Container.shared.netify())
        let viewModel = FilterScreenViewModelIml(service: service)
        return FilterScreen(viewModel: viewModel)
    }
}
