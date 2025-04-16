//
//  FilterViewModel.swift
//  EMSwiftUI
//
//  Created by Глеб Капустин on 16.04.2025.
//

import Combine

protocol IFilterViewModel: ObservableObject {
    var menuIsPresenting: [Bool] { get set }
    var dropDownContent: [DropDownMenuModel] { get }
    var selectedTags: [TagItem] { get set }
}

final class FilterViewModel: IFilterViewModel {
    @Published var menuIsPresenting: [Bool] = []
    @Published var dropDownContent: [DropDownMenuModel] = []
    @Published var selectedTags: [TagItem] = []

    init(dropDownContent: [DropDownMenuModel] = DropDownMenuModel.mock) {
        self.menuIsPresenting = .init(repeating: false, count: dropDownContent.count)
        self.dropDownContent = dropDownContent
    }
}
