//
//  TagButton.swift
//  EMSwiftUI
//
//  Created by Денис Хафизов on 15.10.2024.
//

import SwiftUI

struct TagButton: View {
    let item: String
    let isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(item)
                .font(.custom(FontFamily.SFPro.medium, size: 16))
                .padding(10)
                .background(isSelected ? .orangeBase : .grayBase)
                .foregroundColor(isSelected ? .whiteText : .blackBase)
                .cornerRadius(8)
        }
    }
}

