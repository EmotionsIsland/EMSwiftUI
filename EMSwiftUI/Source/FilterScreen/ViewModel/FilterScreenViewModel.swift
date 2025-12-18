import Foundation

final class FilterScreenViewModel: ObservableObject {
    @Published var tag: FilterTagModel?
    @Published private(set) var tagsSelected: [Tag] = []
    @Published private(set) var isLoading = false
    @Published var category: [String] = ["Selection"]
    
    private let service: FilterListService
    
    var filterSelectionModel: FilterSelectionModel {
        return FilterSelectionModel(
            category: category.first ?? "Selection",
            selectedTags: tagsSelected,
            onTagSelect: { [weak self] tag in self?.changeStateTag(for: tag) },
            onReset: { [weak self] in self?.resetTags() }
        )
    }
    
    let navigationTitle = "Filters"
    
    init(service: FilterListService) {
        self.service = service
    }
    
    @MainActor
    func getTags() async {
        self.isLoading = true
        do {
            let tag = try await service.getTags()
            await getCategory(from: tag)
            self.tag = tag
        } catch {
            print(error)
        }
        self.isLoading = false
    }
    
    @MainActor
    private func getCategory(from tag: FilterTagModel) async {
        var result: [String] = []
        var seen: Set<String> = []
        
        for item in tag.data {
            let category = item.attributes.group
            let formattedCategory = category.prefix(1).uppercased() + category.dropFirst()
            
            if !seen.contains(formattedCategory) {
                result.append(formattedCategory)
                seen.insert(formattedCategory)
            }
        }
        
        self.category += result
    }
    
    private func filterCategory(_ category: String) -> [Tag] {
        return tag?.data.filter { $0.attributes.group == category.lowercased() } ?? []
    }
    
    private func resetTags() {
        tagsSelected = []
    }
    
    private func changeStateTag(for tag: Tag) {
        if let index = tagsSelected.firstIndex(where: { $0.id == tag.id }) {
            self.tagsSelected.remove(at: index)
        } else {
            self.tagsSelected.append(tag)
        }
    }
    
    func toggleTag(for tag: Tag, in category: String) {
        changeStateTag(for: tag)
    }
    
    func filterSectionModel(at category: String) -> FilterSectionModel {
        let tags = filterCategory(category)
        let selectedStates = tags.map { tag in
            tagsSelected.contains(where: { $0.id == tag.id })
        }
        
        return FilterSectionModel(
            category: category,
            tags: tags,
            isSelected: selectedStates
        )
    }
}
