//
//  TagChip.swift
//  EMSwiftUI
//
//  Created by Дарья Саитова on 28.05.2026.
//

import SwiftUI

struct TagChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Text(title)
            .font(.SFPro.bodyNormal)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(isSelected ? Color.orangeBase : Color.grayBase)
            .foregroundStyle(isSelected ? .white : .blackBase)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .fixedSize(horizontal: true, vertical: false) 
            .onTapGesture(perform: action)
    }
}
