//
//  FilterModel.swift
//  EMSwiftUI
//
//  Created by Vladislav Miroshnichenko on 18.07.2024.
//

import Foundation

struct FilterModel: Identifiable, Hashable {
    var id = UUID()
    let type: MangaType
    let tags: [String]
}

extension FilterModel {
    
    static var mocks: [FilterModel] = [
        .init(type: .ContentRaiting, tags: [
            "Everyone", "Youth", "Teens", "Older Teens", "Mature"
        ]),
        .init(type: .PublicationStatus,
              tags: ["Ongoing", "Finished", "Debut"]),
        .init(type: .MagazineDemographic,
              tags: ["Children", "Shonen", "Shojo", "Seinen", "Josei"]),
        .init(type: .Format, tags: ["Сollection", "In color", "Dojinshi", "Webtoon", "Single"]),
        .init(type: .Genre, tags: ["Comedy", "Mecha", "Cooking", "Slice", "Isekai"]),
        .init(type: .Theme, tags: ["Comedies", "Romances", "Adventure stories", "Detective stories", "Historical", "Chivalrous stories"])
        
    ]
    
}
