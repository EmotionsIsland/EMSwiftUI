//
//  Logger+Extensions.swift
//  EMSwiftUI
//
//  Created by Kirill Pukhov on 29.03.2025.
//

import OSLog

extension Logger {
    static let standard = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "standard")
}
