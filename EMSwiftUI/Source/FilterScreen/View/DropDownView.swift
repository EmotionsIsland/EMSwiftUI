//
//  DropDownView.swift
//  EMSwiftUI
//
//  Created by Глеб Капустин on 16.04.2025.
//

import SwiftUI

struct DropDownView: View {
    let title: String
    let tagElements: [TagItem]
    let selectedTags: [TagItem]
    let onMenuItem: (TagItem) -> Void
    @State private var menuIsPresenting: Bool = false

    var body: some View {
        VStack {
            Button {
                menuIsPresenting.toggle()
            } label: {
                HStack(spacing: 8) {
                    Text(title)
                        .foregroundStyle(Color.blackBase)
                        .font(Font.SFPro.regularLarge)

                    Image(.expandDown)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                        .foregroundStyle(Color.blackBase)
                        .rotationEffect(.degrees(menuIsPresenting ? -90 : 0))
                        .animation(.easeInOut, value: menuIsPresenting)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .contentShape(Rectangle())
            }

            if menuIsPresenting {
                FlexibleView(
                    data: tagElements,
                    spacing: 8,
                    alignment: .leading
                ) { item in
                    menuItem(item)
                }
            }
        }
    }
}

private extension DropDownView {
    func menuItem(_ item: TagItem) -> some View {
        let isSelected = selectedTags.contains(item)
        return Button {
            if !isSelected {
                onMenuItem(item)
            }
        } label: {
            HStack(spacing: 4) {
                if isSelected {
                    Image(.addIcon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .foregroundStyle(Color.whiteText)
                }

                Text(item.text)
                    .foregroundStyle(isSelected ? Color.whiteText : Color.blackBase )
                    .font(Font.SFPro.bodyNormal)
            }
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(isSelected ? Color.orangeBase : Color.whiteText)
            )
        }
    }
}
