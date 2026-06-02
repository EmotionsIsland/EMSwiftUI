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
        let netify = Container.shared.netify()
        let service = TagServiceImpl(netify: netify)
        let mapper = TagGroupMapperImpl()
        let viewModel = FilterScreenViewModelImpl(tagService: service, mapper: mapper)
        return FilterScreen(viewModel: viewModel)
    }
}
