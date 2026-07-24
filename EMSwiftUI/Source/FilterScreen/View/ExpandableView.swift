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
                FlowLayout(
                    items: tags
                ) { tag in
                    Text((viewModel.isSelected(tag) ? "＋ " : "") + (tag.attributes.name.en ?? "Unknown"))
                        .frame(minHeight: 36)
                        .fixedSize(horizontal: true, vertical: true)
                        .padding(.horizontal, 8)
                        .font(.SFPro.bodyNormal)
                        .foregroundStyle(viewModel.isSelected(tag) ? .white : .blackBase)
                        .background(viewModel.isSelected(tag) ? .orangeBase : .whiteText)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .onTapGesture {
                            withAnimation {
                                viewModel.toggleSelection(for: tag)
                            }
                        }
                }
            }
        }
    }
}
