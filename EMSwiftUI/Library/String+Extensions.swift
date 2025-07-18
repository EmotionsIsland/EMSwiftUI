//
//  String+Extensions.swift
//  EMSwiftUI
//
//  Created by Alina Kazantseva on 7/17/25.
//

import UIKit

extension String: @retroactive Identifiable {
    public var id: String {
        UUID().uuidString
    }
}

extension String {
    func width(withFont font: UIFont) -> CGFloat {
        let attributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: attributes)
        return ceil(size.width)
    }
}
