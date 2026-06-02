//
//  SelectedTagsSection.swift
//  EMSwiftUI
//
//  Created by Дарья Саитова on 28.05.2026.
//

import SwiftUI
import UIKit

extension String {
    func width(withFont font: UIFont) -> CGFloat {
        let attributes = [NSAttributedString.Key.font: font]
        let size = (self as NSString).size(withAttributes: attributes)
        return ceil(size.width)
    }
}

struct SelectedTagsSection<VM: FilterScreenViewModel>: View {
    @ObservedObject var viewModel: VM
    let onApply: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Selection")
                .font(.SFPro.headline3)
                .foregroundStyle(.blackBase)

            FlowLayout(
                items: viewModel.selectedItems.sorted(by: { $0.title < $1.title }),
                spacing: 8,
                itemWidthProvider: { tag in
                    let font = UIFont(name: "SFProText-Regular", size: 15)
                    ?? .systemFont(ofSize: 15)
                    let text = "+ \(tag.title)"
                    let textWidth = text.width(withFont: font)
                    return textWidth + 24
                },
                content: { tag in
                    TagChip(
                        title: "+ \(tag.title)",
                        isSelected: true,
                        action: { viewModel.toggleSelection(for: tag) }
                    )
                }
            )
            .id(viewModel.selectedItems.map(\.id).sorted().joined(separator: "|"))
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Button("Apply") {
                onApply()
            }
            .font(.SFPro.mediumNormal)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(Color.orangeBase)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.top, 20)
            
            Button("Reset") {
                viewModel.resetSelection()
            }
            .font(.SFPro.mediumNormal)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .foregroundStyle(.blackBase)
        }
    }
}
