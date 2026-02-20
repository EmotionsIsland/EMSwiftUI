//
//  FilterModel.swift
//  EMSwiftUI
//
//  Created by Дарина Самохина on 18.02.2026.
//

import Foundation

struct FilterModel: Decodable {
    let result: String
    let response: String
    let data: [Tag]
    let limit: Int
    let offset: Int
    let total: Int
}
