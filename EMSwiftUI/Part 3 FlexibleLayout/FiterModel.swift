import Foundation


struct Filter: Identifiable, Decodable {
    let id = UUID()
    let name: String
    let tags: [String]
}

extension Filter {
    static let ratingFilter = Filter(name: "rating", tags: ["pg", "pg-13", "r"])
    static let genreFilter = Filter(name: "genre", tags: ["action", "detective"])
    static let formatFilter = Filter(name: "format", tags: ["long strip"])
    static let themeFilter = Filter(name: "theme", tags: ["martial arts"])
    static let filters: [Filter] = [ratingFilter, genreFilter, formatFilter, themeFilter]
}
