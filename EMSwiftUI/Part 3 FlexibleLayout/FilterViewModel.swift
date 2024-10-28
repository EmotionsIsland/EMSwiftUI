import Foundation

class FilterViewModel: ObservableObject {
    
    @Published var selection: [String] = []

    private(set) var filetrs = Filter.filters

    func resetSelection() {
        selection.removeAll()
    }
    
    func addToSelection(item: String) {
        selection.append(item)
    }
    
    func isTagInSelection(item: String) -> Bool {
        selection.contains(item)
    }
}
