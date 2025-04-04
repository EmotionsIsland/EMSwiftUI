import Factory
import Foundation
import Netify

enum SizeFormat: String {
    case size256 = ".256.jpg"
    case size512 = ".512.jpg"
    case size1024 = ".1024.jpg"
}

extension API {
    static let api: Self = API(host: "api.mangadex.org")
    static let coverURL: Self = API(host: "uploads.mangadex.org")
    
    static var mangaList: Endpoint {
        let queryItems = [
            URLQueryItem(name: "limit", value: "6"),
            URLQueryItem(name: "contentRating[]", value: "safe"),
            URLQueryItem(name: "order[followedCount]", value: "desc"),
            URLQueryItem(name: "includes[]", value: "cover_art")
        ]
        return api.endpoint(path: "/manga", queryItems: queryItems)
    }
    
    static var mangaTags: Endpoint {
        return api.endpoint(path: "/manga/tag")
    }

    static func coverURL(for manga: MangaData, _ sizeFormat: SizeFormat = .size512) -> URL? {
        guard let fileName = manga.relationships.first(where: { $0.type == "cover_art" })?.attributes?.fileName else { return nil }
        return coverURL.endpoint(path: "/covers/\(manga.id)/\(fileName)\(sizeFormat.rawValue)").url
    }
}
