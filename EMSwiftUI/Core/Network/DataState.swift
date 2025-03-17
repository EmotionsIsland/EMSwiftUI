//
//  DataState.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import Foundation

enum DataState {
    case successfull
    case failed(error: Error)
    case notAvailable
}
