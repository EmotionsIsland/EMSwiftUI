//
//  FilterTagGridView.swift
//  EMSwiftUI
//
//  Created by Home on 09.01.2026.
//


//
//  FilterTagGridView.swift
//  EMSwiftUI
//

import SwiftUI

struct FilterTagGridView: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 16, weight: .medium))
                .lineLimit(1)
                .frame(maxWidth: .infinity)  // ← растягиваем на всю ширину колонки
                .padding(.horizontal, 16)
                .padding(.vertical, 14)
                .background(isSelected ? Color.orangeBase : Color.grayBase)
                .foregroundColor(isSelected ? .white : .black)
                .cornerRadius(8)
        }
    }
}