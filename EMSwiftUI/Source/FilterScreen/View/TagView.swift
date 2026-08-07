//
//  TagView.swift
//  EMSwiftUI
//
//  Created by Danila Umnov on 07.08.2026.
//

import SwiftUI

struct TagView: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Text(title)
            .frame(minHeight: 36)
            .fixedSize(horizontal: true, vertical: true)
            .padding(.horizontal, 8)
            .font(.SFPro.bodyNormal)
            .foregroundStyle(isSelected ? .white : .blackBase)
            .background(isSelected ? .orangeBase : .whiteText)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .onTapGesture {
                withAnimation {
                    action()
                }
            }
    }
}
