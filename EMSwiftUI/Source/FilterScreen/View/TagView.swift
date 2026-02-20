//
//  TagView.swift
//  EMSwiftUI
//
//  Created by Дарина Самохина on 19.02.2026.
//

import SwiftUI

struct TagView: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: { withAnimation { action() }}, label: {
            HStack(spacing: 4) {
                if isSelected {
                    Image(systemName: "plus")
                        .resizedToFill(width: 20, height: 20)
                        .padding(.leading, 8)
                }
                
                Text(title)
                    .font(.SFPro.bodyNormal)
                    .padding(.vertical, 8)
                    .padding(.trailing, 8)
                    .padding(.leading, isSelected ? 0 : 8)
            }
            .frame(height: 36)
            .background(isSelected ? .orangeBase : .grayBase)
            .foregroundColor(isSelected ? .whiteText : .blackBase)
            .cornerRadius(8)
        })
    }
}
