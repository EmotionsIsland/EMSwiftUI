//
//  TapPillView.swift
//  EMSwiftUI
//
//  Created by Анатолий Чириков on 24.03.2026.
//

import SwiftUI

struct TapPillView: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                if isSelected {
                    Image(systemName: "plus")
                        .font(Font.SFPro.semiboldNormal)
                }
                Text(title)
                    .font(Font.SFPro.semiboldNormal)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .foregroundStyle(isSelected ? Color.whiteText : Color.blackBase)
            .background(isSelected ? Color.orangeBase : Color.grayBase)
            .cornerRadius(8)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
