import Foundation

struct FilterSelectionModel {
    let category: String
    let selectedTags: [Tag]
    let onTagSelect: (Tag) -> Void
    let onReset: () -> Void
}
