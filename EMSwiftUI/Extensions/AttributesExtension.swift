//
//  MangaListModelExtension.swift
//  EMSwiftUI
//
//  Created by Kristina Grebneva on 06.03.2025.
//

import Foundation

// добавлено как расширение, чтобы не изменять модель
extension Attributes {
    var unwrappedTitle: String {
        self.title.en ?? self.altTitles.first {$0.ru != nil}?.ru ?? "Untitled"
    }
    
    var unwrappedDescription: String {
        self.description.en ?? "Unspecified"
    }
}
