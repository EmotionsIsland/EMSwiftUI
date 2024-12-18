//
//  StringExtensions.swift
//  EMSwiftUI
//
//  Created by Иван Незговоров on 17.12.2024.
//

import UIKit

extension String {
    func sizeOfString(usingFont font: UIFont) -> CGSize {
        let attributes = [NSAttributedString.Key.font: font]
        let size = (self as NSString).size(withAttributes: attributes)
        return size
    }
}
