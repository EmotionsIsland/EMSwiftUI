import Foundation

enum MangaCategory: String, CaseIterable {
    case popular = "Popular"
    case recentlyAdded = "Recently Added"
    case lastUpdated = "Last Updates"
    case seasonal = "Seasonal"
    
    var queryItems: [URLQueryItem] {
        var baseQuery = [
            URLQueryItem(name: "limit", value: "6"),
            URLQueryItem(name: "contentRating[]", value: "safe"),
            URLQueryItem(name: "includes[]", value: "cover_art")
        ]
        
        switch self {
        case .popular:
            baseQuery.append(URLQueryItem(name: "order[followedCount]", value: "desc"))
            
        case .recentlyAdded:
            baseQuery.append(URLQueryItem(name: "order[createdAt]", value: "desc"))
            
        case .lastUpdated:
            baseQuery.append(URLQueryItem(name: "order[updatedAt]", value: "desc"))
            
        case .seasonal:
            let currentYear = Calendar.current.component(.year, from: Date())
            baseQuery.append(URLQueryItem(name: "year", value: "\(currentYear)"))
            baseQuery.append(URLQueryItem(name: "order[followedCount]", value: "desc"))
        }
        
        return baseQuery
    }
}
