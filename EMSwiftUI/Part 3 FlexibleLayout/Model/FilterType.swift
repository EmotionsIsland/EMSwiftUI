//
//  FilterType.swift
//  EMSwiftUI
//
//  Created by Александра Сергеева on 21.10.2024.
//

import Foundation

enum FilterType: String, CaseIterable {
    case theme
    case genre
    case rating = "Content Rating"
    case status = "Publication Status"
    case demographic = "Magazine Demographic"
    case format
}
