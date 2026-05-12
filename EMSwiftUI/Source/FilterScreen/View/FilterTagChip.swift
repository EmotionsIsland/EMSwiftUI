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
            .padding(8)
            .background(isSelected ? Color.orangeBase : Color.grayBase)
            .foregroundStyle(isSelected ? .white : .blackBase)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .onTapGesture(perform: onTap)
    }
}
