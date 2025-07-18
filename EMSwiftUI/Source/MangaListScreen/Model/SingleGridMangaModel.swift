//
//  SingleGridMangaModel.swift
//  EMSwiftUI
//
//  Created by Alina Kazantseva on 7/13/25.
//

import SwiftUI

struct SingleGridMangaModel: Identifiable {
    var url: URL?
    let tags: [String]
    let title: String
    
    let rating = 4.3
    let id = UUID().uuidString
}
