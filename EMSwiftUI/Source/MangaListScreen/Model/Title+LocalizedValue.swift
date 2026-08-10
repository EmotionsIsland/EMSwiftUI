//
//  Title+LocalizedValue.swift
//  EMSwiftUI
//
//  Created by Danila Umnov on 10.08.2026.
//

protocol LocalizedValue {
    func value(for languageCode: String) -> String?
}

extension Title: LocalizedValue {
    func value(for languageCode: String) -> String? {
        switch languageCode {
        case "en":
            return en
        case "ru":
            return ru
        case "jaRo":
            return jaRo
        default:
            return nil
        }
    }
}

extension AlternativeTitle: LocalizedValue {
    func value(for languageCode: String) -> String? {
        switch languageCode {
        case "en":
            return en
        case "ru":
            return ru
        case "jaRo":
            return jaRo
        default:
            return nil
        }
    }
}
