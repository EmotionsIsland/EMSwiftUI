import Foundation

class FilterViewModel: ObservableObject {
    
    @Published var contentRating = [
        "1", "2", "3", "4", "5"
    ]
    
    @Published var publicationStatus = [
        "Published", "Coming soon"
    ]
    
    @Published var magazineDemographic = [
        "qwe", "asd", "zxc"
    ]
    
    @Published var format = [
        "Full", "Ne full"
    ]
    
    @Published var theme = [
        "Theme 1", "Theme 2"
    ]
    
    @Published var genre = [
        "Winning awards", "Action", "Drama", "Fantasy", "Comedy"
    ]
    
    @Published var selection = Set<String>()
    
    func resetSelection() {
        selection.removeAll()
    }
    
    func addToSelection(item: String) {
        selection.insert(item)
    }
    
    func isTagInSelection(item: String) -> Bool {
        selection.contains(item)
    }
}
