//
//  String+Extension.swift
//  EMSwiftUI
//
//  Created by Katerina Ivanova on 29.06.2025.
//

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
}
