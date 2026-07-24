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
                Text("＋ \(tag.attributes.name.en ?? "Unknown")")
                    .frame(minHeight: 36)
                    .fixedSize(horizontal: true, vertical: true)
                    .padding(.horizontal, 8)
                    .font(.SFPro.bodyNormal)
                    .foregroundStyle(.white)
                    .background(.orangeBase)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .onTapGesture {
                        withAnimation {
                            viewModel.toggleSelection(for: tag)
                        }
                    }
            }
            .padding(.bottom, 18)
            Button("Apply") { }
                .font(.SFPro.mediumNormal)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(.orangeBase)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            Button("Reset") { viewModel.resetSelection() }
                .font(.SFPro.mediumNormal)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .foregroundStyle(.blackBase)
        } 
        .animation(.easeInOut(duration: 0.25), value: viewModel.selectedTags.count)
    }
}
