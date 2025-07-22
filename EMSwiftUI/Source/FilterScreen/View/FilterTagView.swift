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
                        .foregroundStyle(.white)
                }
                Text(tag.attributes.name.en ?? "No title")
                    .font(.subheadline)
                    .lineLimit(1)
                    .foregroundColor(isSelected ? Color.white : Color.black)
                    .padding(.trailing, 8)
            }
            .padding(8)
        }
        .buttonStyle(PlainButtonStyle())
        .background(isSelected ? Color.init(cgColor: #colorLiteral(red: 1, green: 0.4928947091, blue: 0.3157388568, alpha: 1)) : Color.init(cgColor: #colorLiteral(red: 0.9098039216, green: 0.9098039216, blue: 0.9137254902, alpha: 1)))
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
