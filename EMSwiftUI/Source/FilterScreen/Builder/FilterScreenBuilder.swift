//
//  FilterScreenBuilder.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 17/3/25.
//

import SwiftUI

final class FilterScreenBuilder {
    static func build() -> some View {
        let viewModel = FilterViewModel()
        let view = FilterScreen(viewModel: viewModel)

        return view
    }
}
