import Foundation
import Netify
import Combine

protocol FilterScreenViewModel: ObservableObject {
    var tagModel: TagListModel? { get set }
    var selectionCategories: [TagData] { get set }
    var spacingBetweenCategories: CGFloat { get set }
    var selectionCategoriesPublisher: AnyPublisher<[TagData], Never> { get }
    var layoutNeedsUpdate: Bool { get set }
    func filterByFormat() -> [TagData]
    func filterByGenre() -> [TagData]
    func filterByTheme() -> [TagData]
    func isSelected(_ tag: TagData) -> Bool
}

final class FilterScreenViewModelImpl: FilterScreenViewModel {
    @Published var tagModel: TagListModel?
    @Published var selectionCategories: [TagData] = []
    @Published var layoutNeedsUpdate = false
    
    private var filteredTags: [TagData] = []
    private let service: FilterScreenService
    
    func isSelected(_ tag: TagData) -> Bool {
        selectionCategories.contains(where: { $0.id == tag.id })
    }
    
    var spacingBetweenCategories: CGFloat = 10
    var selectionCategoriesPublisher: AnyPublisher<[TagData], Never> {
        $selectionCategories.eraseToAnyPublisher()
    }

    init(service: FilterScreenService) {
        self.service = service
        Task {
            try? await getTags()
        }
    }
    
    @MainActor private func getTags() async throws {
        tagModel = try await service.getMangaTags()
    }
}

// MARK: - Filters for tagModel
extension FilterScreenViewModelImpl {
    func filterByFormat() -> [TagData] {
        filteredTags = []
        filteredTags = tagModel?.data.filter { $0.attributes.group == "format"} ?? []
        return filteredTags
    }
    
    func filterByGenre() -> [TagData] {
        filteredTags = []
        filteredTags = tagModel?.data.filter { $0.attributes.group == "genre"} ?? []
        return filteredTags
    }
    
    func filterByTheme() -> [TagData] {
        filteredTags = []
        filteredTags = tagModel?.data.filter { $0.attributes.group == "theme"} ?? []
        return filteredTags
    }
}
