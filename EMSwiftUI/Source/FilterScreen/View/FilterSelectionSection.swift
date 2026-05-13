//
//  FilterSelectionSection.swift
//  EMSwiftUI
//
//  Created by Kseniya Semenova on 12.05.2026.
//

import SwiftUI

struct FilterSelectionSection<VM: FilterViewModel>: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: VM

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Selection")
                .font(.SFPro.headline3)
                .foregroundStyle(.blackBase)
            FlexibleLayout(data: viewModel.selectedTagsOrdered, spacing: 8) { tag in
                FilterTagChip(
                    title: "+ \(tag.title)",
                    isSelected: true,
                    onTap: { viewModel.toggleTag(tag) }
                )
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .id(viewModel.selectedTagsOrdered.map(\.id).sorted().joined(separator: "|"))

            Button(
                action: {
                    dismiss()
                },
                label: {
                    Text("Apply")
                        .font(.SFPro.mediumNormal)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color.orangeBase)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            )
            Button(
                action: {
                    viewModel.reset()
                },
                label: {
                    Text("Reset")
                        .font(.SFPro.mediumNormal)
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(Color.blackBase)
                }
            )
        }
        .padding(.vertical, 16)
    }
}
