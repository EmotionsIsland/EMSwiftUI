//
//  SectionDataModel.swift
//  EMSwiftUI
//
//  Created by Alina Kazantseva on 7/15/25.
//

import Foundation

struct SectionDataModel: Identifiable {
    let title: String
    let items: [SingleGridMangaModel]
    var id = UUID().uuidString
}
