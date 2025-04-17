//
//  FilterViewModel.swift
//  EMSwiftUI
//
//  Created by Глеб Капустин on 16.04.2025.
//

import Combine

protocol FilterViewModel: ObservableObject {
    var dropDownContent: [DropDownMenuModel] { get }
    var selectedTags: [TagItem] { get }
    func addSelectedTag(_ tag: TagItem)
    func removeAllSelectedTags()
}

final class FilterViewModelImpl: FilterViewModel {
    private let service: FilterService

    @Published private(set) var dropDownContent: [DropDownMenuModel] = []
    @Published private(set) var selectedTags: [TagItem] = []

    init(service: FilterService) {
        self.service = service

        Task {
            await getData()
        }
    }

    func addSelectedTag(_ tag: TagItem) {
        selectedTags.append(tag)
    }

    func removeAllSelectedTags() {
        selectedTags.removeAll()
    }
}

private extension FilterViewModelImpl {
    @MainActor func getData() async {
        let tagModel = try? await service.getTags()

        self.dropDownContent = tagModel?.toDropDownMenuModel() ?? []
    }
}

private extension TagModel {
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
