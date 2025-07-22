//
//  ExtensionCollection.swift
//  EMSwiftUI
//
//  Created by Новгородцев Никита on 21/07/2025.
//

import Foundation

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
