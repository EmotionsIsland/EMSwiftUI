//
//  LoadState.swift
//  EMSwiftUI
//
//  Created by Дарья Саитова on 06.06.2026.
//

enum LoadState<Value> {
    case loading
    case loaded(Value)
    case error(String)
}

extension LoadState: Equatable where Value: Equatable {}
