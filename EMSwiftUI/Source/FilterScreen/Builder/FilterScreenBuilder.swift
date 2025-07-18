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
        let service = FilterScreenServiceImpl(netify: Container.shared.netify())
        let viewModel = FilterScreenViewModelImpl(service: service)
        let filterScreen = FilterScreenView(viewModel: viewModel)
        
        return filterScreen
    }
}
