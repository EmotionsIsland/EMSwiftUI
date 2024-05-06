import Foundation

enum MangaFilter {
    enum ContentRating: String, CaseIterable {
        case word = "Word"
        case apple = "Apple"
        case peeping = "Peeping"
        case understand = "Understand"
    }
    
    enum PublicationStatus: String, CaseIterable {
        case writing = "Writing"
        case accomplished = "Accomplished"
        case suspended = "Suspended"
    }
}
