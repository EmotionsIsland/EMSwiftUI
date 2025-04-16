//
//  DropDownView.swift
//  EMSwiftUI
//
//  Created by Глеб Капустин on 16.04.2025.
//

import SwiftUI

struct DropDownView: View {
    private let title: String
    private let tagElements: [TagItem]
    @Binding var menuIsPresenting: Bool
    @Binding var selectedTags: [TagItem]

    init(tagElements: [TagItem], title: String, menuIsPresenting: Binding<Bool>, selectedTags: Binding<[TagItem]>) {
        self.title = title
        self.tagElements = tagElements
        self._menuIsPresenting = menuIsPresenting
        self._selectedTags = selectedTags
    }

    var body: some View {
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
            .drawingGroup()
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

private extension DropDownView {
    func menuItem(_ item: TagItem) -> some View {
        Button {
            if !selectedTags.contains(item) {
                selectedTags.append(item)
            }
        } label: {
            if selectedTags.contains(item) {
                HStack(spacing: 4) {
                    Image(.addIcon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .foregroundStyle(Color.whiteText)

                    Text(item.text)
                        .foregroundStyle(Color.whiteText)
                        .font(Font.SFPro.bodyNormal)
                }
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.orangeBase)
                )
            } else {
                Text(item.text)
                    .foregroundStyle(Color.blackBase)
                    .font(Font.SFPro.bodyNormal)
                    .padding(8)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.whiteText)
                    )
            }
        }
    }
}
