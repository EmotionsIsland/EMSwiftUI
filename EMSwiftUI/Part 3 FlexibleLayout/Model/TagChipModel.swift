//
//  TagChipModel.swift
//  EMSwiftUI
//
//  Created by Алсу Хайруллина on 14.10.2024.
//

import Foundation

struct TagChipModel: Identifiable, Hashable {
    
    let id = UUID().uuidString
    let title: String
    var isSelected: Bool = false
    
    static func == (lhs: TagChipModel, rhs: TagChipModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

//extension TagChipModel {
//    
//    static func == (lhs: TagChipModel, rhs: TagChipModel) -> Bool {
//        return lhs.id == rhs.id
//    }
//    
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(id)
//    }
//}

extension TagChipModel {
    
    static let mockPulicationStatusTags = [TagChipModel(title: "Ongoing"),
                                           TagChipModel(title: "Finished"),
                                           TagChipModel(title: "Not Stated")
    ]
    
    static let mockGenreTags = [TagChipModel(title: "Manga"),
                                TagChipModel(title: "Fantasy"),
                                TagChipModel(title: "Slice of Life"),
                                TagChipModel(title: "Isekai"),
                                TagChipModel(title: "Seinen"),
                                TagChipModel(title: "Sports")
    ]
    
    static let mockFormatTags = [TagChipModel(title: "Manga"),
                                 TagChipModel(title: "Light Novel"),
                                 TagChipModel(title: "One-shot"),
                                 TagChipModel(title: "Doujinshi"),
                                 TagChipModel(title: "Webtoon"),
                                 TagChipModel(title: "Manhwa")
    ]
    
}
