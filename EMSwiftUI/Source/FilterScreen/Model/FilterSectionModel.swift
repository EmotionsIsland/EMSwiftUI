import Foundation

struct FilterSectionModel {
    let category: String
    let tags: [Tag]
    let isSelected: [Bool]
    let onTagSelect: (Tag) -> Void
}
