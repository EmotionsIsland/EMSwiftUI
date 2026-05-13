//
//  FilterTagChip.swift
//  EMSwiftUI
//
//  Created by Kseniya Semenova on 12.05.2026.
//

import SwiftUI

struct FilterTagChip: View {
    let title: String
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Text(title)
            .font(.SFPro.bodyNormal)
            .lineLimit(1)
            .padding(8)
            .background(isSelected ? Color.orangeBase : Color.grayBase)
            .foregroundStyle(isSelected ? .white : .blackBase)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .fixedSize(horizontal: true, vertical: false)
            .onTapGesture(perform: onTap)
    }
}
