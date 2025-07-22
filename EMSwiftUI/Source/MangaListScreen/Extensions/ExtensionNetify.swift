//
//  ExtensionNetify.swift
//  EMSwiftUI
//
//  Created by Новгородцев Никита on 21/07/2025.
//

import Foundation
import Netify

public extension Netify {
    func requestRawData(_ endpoint: Endpoint) async throws -> Data {
        let (data, _) = try await URLSession.shared.data(from: endpoint.url)
        return data
    }
}
