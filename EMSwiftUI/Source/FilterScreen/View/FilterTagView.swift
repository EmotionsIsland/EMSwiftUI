//
//  FilterTagView.swift
//  EMSwiftUI
//
//  Created by Новгородцев Никита on 22/07/2025.
//

import SwiftUI

struct FilterTagView: View {
    let tag: Tag
    let isSelected: Bool
    let action: (_ tagSelected: Tag) -> Void
    
    var body: some View {
        Button {
            action(tag)
        } label: {
            HStack(spacing: 4) {
                if isSelected {
                    Image(systemName: "plus")
                        .foregroundStyle(Color.whiteText)
                }
                Text(tag.attributes.name.en ?? "No title")
                    .font(.subheadline)
                    .lineLimit(1)
                    .foregroundColor(isSelected ? Color.whiteText : Color.blackBase)
                    .padding(.trailing, 8)
            }
            .padding(8)
        }
        .buttonStyle(PlainButtonStyle())
        .background(isSelected ? Color.orangeBase : Color.whiteText)
        .cornerRadius(10)
    }
}

#Preview {
    FilterTagView(
        tag: Tag(id: "1",
                 type: "tag",
                 attributes: TagAttributes(
                    name: Title(en: "Award Winning"),
                    group: "format")),
        isSelected: false,
        action: {_ in })
}
