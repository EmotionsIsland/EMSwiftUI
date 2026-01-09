import Foundation
import Combine

protocol FilterScreenViewModel: ObservableObject {
    var allFilterTitles: [FilterTypes] { get }
    var allAvailableFilters: [FilterTypes: [String]] { get }
    var selectedFilters: Set<String> { get }
    var expandedSections: Set<FilterTypes> { get }
    
    func toggleFilter(_ filter: String)
    func toggleSection(_ section: FilterTypes)
    func resetFilters()
    func isFilterSelected(_ filter: String) -> Bool
}

enum FilterTypes: String, CaseIterable, Hashable {
    case contentRating
    case publicationDemographic
    case status
    case format
    case genre
    case theme
    
    var displayName: String {
        switch self {
        case .contentRating: return "Content Rating"
        case .publicationDemographic: return "Magazine Demographic"
        case .status: return "Publication Status"
        case .format: return "Format"
        case .genre: return "Genre"
        case .theme: return "Theme"
        }
    }
}

final class FilterScreenViewModelImpl: FilterScreenViewModel {
    @Published var selectedFilters: Set<String> = []
    @Published var expandedSections: Set<FilterTypes> = []
    let service: MangaListService
    
    init(service: MangaListService) {
        self.service = service
    }
    
    let allFilterTitles: [FilterTypes] = FilterTypes.allCases
    
    let allAvailableFilters: [FilterTypes: [String]] = [
        .contentRating: ["Safe", "Suggestive", "Erotica", "Pornographic"],
        .publicationDemographic: ["Shounen", "Shoujo", "Seinen", "Josei", "None"],
        .status: ["Ongoing", "Completed", "Hiatus", "Cancelled"],
        .format: ["Manga", "Manhwa", "Manhua", "Comic"],
        .genre: ["Action", "Adventure", "Comedy", "Drama", "Fantasy", "Horror", "Mystery",
                 "Romance", "Sci-Fi", "Slice of Life", "Sports", "Thriller"],
        .theme: ["Award Winning", "Official Colored", "School Life", "Magic", "Time Travel", "Reincarnation", "Isekai", "Supernatural"]
    ]
    
    func toggleFilter(_ filter: String) {
        if selectedFilters.contains(filter) {
            selectedFilters.remove(filter)
        } else {
            selectedFilters.insert(filter)
        }
    }
    
    func toggleSection(_ section: FilterTypes) {
        if expandedSections.contains(section) {
            expandedSections.remove(section)
        } else {
            expandedSections.insert(section)
        }
    }
    
    func resetFilters() {
        selectedFilters.removeAll()
    }
    
    func isFilterSelected(_ filter: String) -> Bool {
        selectedFilters.contains(filter)
    }
}
