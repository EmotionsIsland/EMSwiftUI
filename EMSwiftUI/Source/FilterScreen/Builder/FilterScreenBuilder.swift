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
        let service = FilterScreenService(netify: Container.shared.netify())
        let viewModel = FilterScreenViewModel(service: service)
        let view = FilterScreen(viewModel: viewModel)
        return view
    }
}
