//
//  ModelState.swift
//  EMSwiftUI
//
//  Created by mm pechenbku on 05.06.2025.
//

enum ModelState<T> {
    case loading
    case loaded(T)
    case error
}
