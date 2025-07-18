//
//  SelectedTagView.swift
//  EMSwiftUI
//
//  Created by Alina Kazantseva on 7/16/25.
//

import SwiftUI

struct DistinctTagView: View {
    let title: String
    let isSelected: Bool
    let actionHandler: () -> ()
    
    var body: some View {
        HStack(spacing: 4) {
            if isSelected {
                Image(systemName: "plus")
                    .foregroundStyle(.white)
            }
            Text(title)
                .font(.custom("SFProDisplay-Regular", size: 16))
                .foregroundStyle(isSelected ?
                                 Color.blackBase :
                                 Color.whiteText)
                .lineLimit(1)
                .fixedSize()
        }
        .padding(.vertical, 6)
        .padding(.horizontal, 12)
        .background {
            RoundedRectangle(cornerRadius: 8)
                .fill(isSelected ?
                      Color.orangeBase :
                      Color.grayBase)
        }
        .onTapGesture {
            actionHandler()
        }
        .animation(.spring(response: 0.4, dampingFraction: 0.7), value: isSelected)
    }
}
