//
//  TitleResolver.swift
//  EMSwiftUI
//
//  Created by Danila Umnov on 10.08.2026.
//

struct TitleResolver {
    private let preferredLanguages: [String]

    init(preferredLanguages: [String] = ["en", "ru", "jaRo"]) {
        self.preferredLanguages = preferredLanguages
    }

    func resolve(
        title: Title,
        alternativeTitles: [AlternativeTitle]
    ) -> String? {
        for language in preferredLanguages {
            if let value = title.value(for: language) {
                return value
            }

            if let value = alternativeTitles
                .compactMap({ $0.value(for: language) })
                .first {
                return value
            }
        }

        return nil
    }
}
