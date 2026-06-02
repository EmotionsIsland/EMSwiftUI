//
//  ExpandableTagGroup.swift
//  EMSwiftUI
//
//  Created by Дарья Саитова on 28.05.2026.
//

import SwiftUI

struct ExpandableTagGroup<VM: FilterScreenViewModel>: View {
    @ObservedObject var viewModel: VM
    let groupTitle: String
    let tags: [FilterChipItem]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(groupTitle.capitalized)
                    .font(.SFPro.regularLarge)
                Spacer()
                Image(systemName: viewModel.expandedGroupIDs.contains(groupTitle)
                      ? "chevron.up"
                      : "chevron.down")
                    .font(.SFPro.regularLarge)
            }
            .contentShape(Rectangle())
            .onTapGesture {
                viewModel.toggleGroup(groupTitle)
            }

            if viewModel.expandedGroupIDs.contains(groupTitle) {
                FlowLayout(
                    items: tags,
                    spacing: 8,
                    itemWidthProvider: { tag in
                        let font = UIFont(name: "SFProText-Regular", size: 15)
                        ?? .systemFont(ofSize: 15)
                        let textWidth = tag.title.width(withFont: font)
                        return textWidth + 24
                    },
                    content: { tag in
                        TagChip(
                            title: tag.title,
                            isSelected: viewModel.selectedItems.contains(tag),
                            action: { viewModel.toggleSelection(for: tag) }
                        )
                    }
                )
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 8)
            }
        }
        .padding(.vertical, 16)
    }
}
