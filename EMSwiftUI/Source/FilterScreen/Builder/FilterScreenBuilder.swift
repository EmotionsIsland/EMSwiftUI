//
//  FilterScreenBuilder.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 17/3/25.
//

import SwiftUI
import Factory
import Netify

final class FilterScreenBuilder {
    static func build() -> some View {
        let service = FilterScreenServiceImpl(netify: Container.shared.netify())
        let viewModel = FilterScreenViewModelImpl(service: service)
        let view = FilterScreen(viewModel: viewModel)
        
        return view
    }
}
