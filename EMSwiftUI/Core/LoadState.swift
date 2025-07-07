//
//  LoadState.swift
//  EMSwiftUI
//
//  Created by Глеб Поляков on 07.07.2025.
//

import Foundation

enum LoadState {
    case idle, loading, success, failure(Error)
}
