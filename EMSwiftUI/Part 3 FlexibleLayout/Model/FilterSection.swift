//
//  FilterSection.swift
//  EMSwiftUI
//
//  Created by Максим Шишлов on 17.12.2024.
//

import Foundation

struct FilterSection: Identifiable {
    let id: UUID = .init()
    let title: String
    let tags: [FilterTag]
    var isExpanded: Bool = false
}
