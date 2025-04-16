//
//  TagItem.swift
//  EMSwiftUI
//
//  Created by Глеб Капустин on 16.04.2025.
//

import Foundation

struct TagItem: Hashable {
    let id = UUID()
    let text: String

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension TagItem {
    static let mock = [
        "Here’s", "to", "the", "crazy", "ones", "the", "misfits", "the", "rebels", "the"
    ].map { Self(text: $0) }

    static let mock2 = [
        "Here’s", "to", "the", "crazy", "ones", "the", "misfits", "the", "rebels", "the"
    ].map { Self(text: $0) }

    static let mock3 = [
        "Here’s", "to", "the", "crazy", "ones", "the", "misfits", "the", "rebels", "the"
    ].map { Self(text: $0) }

    static let mock4 = [
        "Here’s", "to", "the", "crazy", "ones", "the", "misfits", "the", "rebels", "the"
    ].map { Self(text: $0) }

    static let mock5 = [
        "Here’s", "to", "the", "crazy", "ones", "the", "misfits", "the", "rebels", "the"
    ].map { Self(text: $0) }

    static let mock6 = [
        "Here’s", "to", "the", "crazy", "ones", "the", "misfits", "the", "rebels", "the"
    ].map { Self(text: $0) }

    static let mock7 = [
        "Here’s", "to", "the", "crazy", "ones", "the", "misfits", "the", "rebels", "the"
    ].map { Self(text: $0) }
}
