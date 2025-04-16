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
    private let service: FilterService

    @Published var menuIsPresenting: [Bool] = []
    @Published var dropDownContent: [DropDownMenuModel] = []
    @Published var selectedTags: [TagItem] = []

    init(service: FilterService) {
        self.service = service

        Task { @MainActor in
            let tagModel = try? await service.getTags()

            self.dropDownContent = tagModel?.toDropDownMenuModel() ?? []
            self.menuIsPresenting = .init(repeating: false, count: dropDownContent.count)
        }
    }
}

fileprivate extension TagModel {
    func toDropDownMenuModel() -> [DropDownMenuModel] {
        let groups = data.reduce(into: [String]()) { result, tag in
            let group = tag.attributes.group
            if !result.contains(group) {
                result.append(group)
            }
        }

        return groups.map { group in
            let tagsInGroup = data.filter { $0.attributes.group == group }
            let tagItems = tagsInGroup.map {
                TagItem(text: $0.attributes.name.en)
            }
            return DropDownMenuModel(title: group.capitalized, tagElements: tagItems)
        }
    }
}
