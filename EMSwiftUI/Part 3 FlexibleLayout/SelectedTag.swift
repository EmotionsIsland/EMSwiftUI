//
//  SelectedTag.swift
//  EMSwiftUI
//
//  Created by Иван Незговоров on 10.12.2024.
//


import SwiftUI

struct SelectedTag: Identifiable, Hashable {
    var id = UUID()
    var text: String
    var select: Bool
}
