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
    
    static var mangaList: Endpoint {
        let queryItems = [
            URLQueryItem(name: "limit", value: "6"),
            URLQueryItem(name: "contentRating[]", value: "safe"),
            URLQueryItem(name: "order[followedCount]", value: "desc"),
            URLQueryItem(name: "includes[]", value: "cover_art")
        ]
        
        return api.endpoint(path: "/manga", queryItems: queryItems)
    }
    
    static var mangaCover: Endpoint {
        api.endpoint(path: "/cover")
    }
}
