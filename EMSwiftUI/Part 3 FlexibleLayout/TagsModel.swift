import Foundation

struct SectionTags: Identifiable, Hashable {
    var id = UUID()
    var showContent: Bool
    var title: String
    var tags: [String]
}
