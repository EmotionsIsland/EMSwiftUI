//
//  FilterGroupSection.swift
//  EMSwiftUI
//
//  Created by Kseniya Semenova on 12.05.2026.
//

import SwiftUI

struct FilterGroupSection<VM: FilterViewModel>: View {
    @ObservedObject var viewModel: VM
    let group: String
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(group.capitalized)
                    .font(.SFPro.regularLarge)

                Image(systemName: viewModel.expandedGroups.contains(group) ? "chevron.up" : "chevron.down")
                    .font(.SFPro.regularLarge)
                    .foregroundStyle(.blackBase)
            }
            .contentShape(Rectangle())
            .onTapGesture {
                viewModel.toggleGroup(group)
            }

            if viewModel.expandedGroups.contains(group) {
                FlexibleLayout(data: viewModel.tags(inGroup: group), spacing: 8) { tag in
                    FilterTagChip(
                        title: tag.title,
                        isSelected: viewModel.selectedTags.contains(tag),
                        onTap: { viewModel.toggleTag(tag) }
                    )
                }
                .id("group-tags-\(group)")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 16)
            }
        }
        .padding(.bottom, 26)
    }
}
