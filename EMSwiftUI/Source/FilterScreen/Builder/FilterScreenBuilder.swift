//
//  FilterScreenBuilder.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 17/3/25.
//

import SwiftUI
import Factory

@available(iOS 16.0, *)
final class FilterScreenBuilder {
    static func build(tabSelected: Binding<TabSelection>) -> some View {
        let service: FilterService = FilterServiceImpl(netify: Container.shared.netify())
        let viewModel = FilterViewModelImpl(service: service)
        let view = FilterScreen(viewModel: viewModel, tabSelected: tabSelected)
        
        return view
    }
}
