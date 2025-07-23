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
        let service: FilterService = FilterServiceImpl(netify: Container.shared.netify())
        let viewModel = FilterViewModelImpl(service: service)
        let view = FilterScreen(viewModel: viewModel)
        
        return view
    }
}
