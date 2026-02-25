//
//  MangaSort .swift
//  EMSwiftUI
//
//  Created by Денис Ефименков on 25.02.2026.
//

import Foundation

enum MangaSort {
    case popular
    case recentlyAdded
    case lastUpdates
    
    var queryItem: URLQueryItem {
        switch self {
        case .popular:
            return URLQueryItem(name: "order[followedCount]", value: "desc")
        case .recentlyAdded:
            return URLQueryItem(name: "order[createdAt]", value: "desc")
        case .lastUpdates:
            return URLQueryItem(name: "order[latestUploadedChapter]", value: "desc")
        }
    }
}
