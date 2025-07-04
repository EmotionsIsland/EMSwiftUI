//
//  FilterViewModel.swift
//  EMSwiftUI
//
//  Created by Katerina Ivanova on 29.06.2025.
//

import Foundation
import Combine

protocol FilterViewModel: AnyObject, ObservableObject {
    var groupedTags: [GroupedTags] { get set }
    var selectedTags: [Tag] { get set }
    var viewState: ViewState { get set }
    func getTags() async
    func applyFilters()
    func resetFilters()
    func containsTag(_ tag: Tag) -> Bool 
}

final class FilterViewModelImpl: FilterViewModel {
    // MARK: Publishers
    @Published private var tags: [Tag] = []
    @Published var viewState: ViewState = .idle
    @Published var groupedTags: [GroupedTags] = []
    @Published var selectedTags: [Tag] = []
    
    // MARK: Properties
    private let service: FilterService
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: Initialization
    init(service: FilterService) {
        self.service = service
        setupTagsSubscription()
    }
}

// MARK: - Private Methods
private extension FilterViewModelImpl {
    func setupTagsSubscription() {
        $tags
            .map { tags -> [GroupedTags] in
                var processedGroups = Set<String>()
                var result = [GroupedTags]()
                
                for tag in tags {
                    let group = tag.attributes.group
                    if !processedGroups.contains(group) {
                        let groupTags = tags.filter { $0.attributes.group == group }
                        result.append(GroupedTags(
                            group: group,
                            isExpanded: false,
                            tags: groupTags
                        ))
                        processedGroups.insert(group)
                    }
                }
                return result
            }
            .assign(to: \.groupedTags, on: self)
            .store(in: &cancellables)
    }
}

extension FilterViewModelImpl {
    func applyFilters() {}
    
    func resetFilters() {
        self.selectedTags.removeAll()
    }
    
    func containsTag(_ tag: Tag) -> Bool {
        selectedTags.contains(tag) ? true : false
    }
}

// MARK: - Network
extension FilterViewModelImpl {
    func getTags() async {
        await MainActor.run {
            viewState = .loading
        }
        do {
            let result = try await service.getTags()
            await MainActor.run {
                self.tags = result.data
                viewState = .success
            }
        } catch {
            await MainActor.run {
                viewState = .error(error.localizedDescription)
            }
        }
    }
}
