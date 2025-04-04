import SwiftUI

enum MangaSection: CaseIterable {
    case popular
    case recentlyAdded
    case lastUpdates
    case seasonal

    var title: String {
        switch self {
        case .popular: return "Popular"
        case .recentlyAdded: return "Recently Added"
        case .lastUpdates: return "Last Updates"
        case .seasonal: return "Seasonal"
        }
    }
}

struct MangaSectionKey: EnvironmentKey {
    static var defaultValue: MangaSection?
}

extension EnvironmentValues {
    var mangaListSection: MangaSection? {
        get { self[MangaSectionKey.self] }
        set { self[MangaSectionKey.self] = newValue }
    }
}
