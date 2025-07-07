//
//  String+Extensions.swift
//  EMSwiftUI
//
//  Created by Глеб Поляков on 06.07.2025.
//

import SwiftUI

extension String {
    func width(withFont font: UIFont) -> CGFloat {
        let attributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: attributes)
        return ceil(size.width)
    }
}
