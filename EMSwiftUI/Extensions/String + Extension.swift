//
//  String + Extension.swift
//  EMSwiftUI
//
//  Created by Денис Хафизов on 15.10.2024.
//

import UIKit

extension String {
    func sizeOfString(usingFont font: UIFont) -> CGSize {
        let attributes = [NSAttributedString.Key.font: font]
        let size = (self as NSString).size(withAttributes: attributes)
        return size
    }
}
