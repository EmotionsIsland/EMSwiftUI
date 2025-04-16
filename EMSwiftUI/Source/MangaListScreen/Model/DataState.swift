//
//  DataState.swift
//  EMSwiftUI
//
//  Created by Глеб Капустин on 16.04.2025.
//

import Foundation

enum DataState {
    case successfull
    case failed(error: Error)
    case notAvailable
}
