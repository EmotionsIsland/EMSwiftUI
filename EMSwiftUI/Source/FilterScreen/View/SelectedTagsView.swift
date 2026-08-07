//
//  SelectedTagsView.swift
//  EMSwiftUI
//
//  Created by Danila Umnov on 23.07.2026.
//

import SwiftUI

struct SelectedTagsView<VM: FilterViewModel>: View {
    @ObservedObject var viewModel: VM

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Selection")
                .font(.SFPro.headline3)
                .foregroundStyle(.blackBase)
                .padding(.bottom, 16)
            FlowLayout(items: viewModel.selectedTags) { tag in
                TagView(
                    title: "＋ \(tag.attributes.name.en ?? "Unknown")",
                    isSelected: true,
                    action: { viewModel.toggleSelection(for: tag) }
                )
            }
            .padding(.bottom, 18)
            Button("Apply") { }
                .orangeButtonStyle()
            Button("Reset") { viewModel.resetSelection() }
                .resetButtonStyle()
        }
        .animation(.easeInOut(duration: 0.25), value: viewModel.selectedTags.count)
    }
}
