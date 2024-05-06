//
//  Endpoint.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import Foundation

struct Endpoint {
    var path: String
    var queryItems: [URLQueryItem] = []
}

extension Endpoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.mangadex.org"
        components.path = path
        components.queryItems = queryItems
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        
        return url
    }
    
    var coverURL: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "uploads.mangadex.org"
        components.path = path
        components.queryItems = queryItems
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        
        return url
    }
}

extension Endpoint {
    static var mangaList: Self {
        let queryItems = [URLQueryItem(name: "limit", value: "6"),
                          URLQueryItem(name: "contentRating[]", value: "safe"),
                          URLQueryItem(name: "order[followedCount]", value: "desc"),
                          URLQueryItem(name: "includes[]", value: "cover_art")]
        
        return Endpoint(path: "/manga", queryItems: queryItems)
    }
    
    static var mangaCover: Self {
        return Endpoint(path: "/cover")
    }
}
