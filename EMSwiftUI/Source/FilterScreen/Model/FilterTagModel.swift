//
//  FilterTagModel.swift
//  EMSwiftUI
//
//  Created by Новгородцев Никита on 22/07/2025.
//

import Foundation

struct FilterTagModel: Decodable {
    let result: String
    let response: String
    let data: [Tag]
}
