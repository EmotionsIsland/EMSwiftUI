//
//  Network.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import Factory
import Foundation
import Netify

extension API {
    static let api: Self = API(host: "api.mangadex.org")
    static let coverURL: Self = API(host: "uploads.mangadex.org")
    
    static func mangaList(sort: MangaSort, limit: Int = 6) -> Endpoint {
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "limit", value: "\(limit)"),
            URLQueryItem(name: "contentRating[]", value: "safe"),
            URLQueryItem(name: "includes[]", value: "cover_art"),
            sort.queryItem
        ]
        
        return api.endpoint(path: "/manga", queryItems: queryItems)
    }
    
    static func mangaTags(sort: TagSort) -> Endpoint {
        api.endpoint(path: "/manga/tag", queryItems: [sort.queryItem])
    }

    static func coverURL(for manga: MangaData, _ sizeFormat: SizeFormat = .size512) -> URL? {
        guard let fileName = manga.relationships.first(where: { $0.type == "cover_art" })?.attributes?.fileName else { return nil }

        return coverURL.endpoint(path: "/covers/\(manga.id)/\(fileName)\(sizeFormat.rawValue)").url
    }
}
