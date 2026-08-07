//
//  ExpandableView.swift
//  EMSwiftUI
//
//  Created by Danila Umnov on 24.07.2026.
//

import SwiftUI

struct ExpandableView<VM: FilterViewModel>: View {
    let title: String
    let tags: [Tag]

    @ObservedObject var viewModel: VM
    @State private var isExpanded: Bool = false

    var body: some View {
        VStack {
            Button {
                withAnimation {
                    isExpanded.toggle()
                }
            } label: {
                HStack {
                    Text(title)
                        .font(.SFPro.regularLarge)
                    Image("moreIcon")
                        .rotationEffect(.degrees(isExpanded ? 0 : 90))
                    Spacer()
                }
                .foregroundStyle(.blackBase)
            }
            if isExpanded {
                FlowLayout(items: tags) { tag in
                    TagView(
                        title: tag.attributes.name.en ?? "Unknown",
                        isSelected: viewModel.isSelected(tag),
                        action: { viewModel.toggleSelection(for: tag) }
                    )
                }
            }
        }
    }
}
