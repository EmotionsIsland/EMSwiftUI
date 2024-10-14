//
//  DropDownTagsView.swift
//  EMSwiftUI
//
//  Created by Алсу Хайруллина on 14.10.2024.
//

import SwiftUI

struct DropDownTagsView: View {
    
    let title: String
    @State private var isExpanded = false
    @Binding var tags: [TagChipModel]
    
    var availableWidth: CGFloat
    let onSelectTag: (TagChipModel, Bool) -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center, spacing: 24) {
                Text(title)
                    .font(FontFamily.SFProText.regular.swiftUIFont(size: 20))
                dropButton
                Spacer()
            }
            expandedView
        }
        .padding(.vertical, 12)
    }
}

private extension DropDownTagsView {
    
    var dropButton: some View {
        Button {
            withAnimation {
                isExpanded.toggle()
            }
        } label: {
            switch self.isExpanded {
                case true: Image(systemName: "chevron.down")
                case false: Image(systemName: "chevron.up")
            }
        }
        .foregroundStyle(.black)

    }
    
    @ViewBuilder var expandedView: some View {
        switch isExpanded {
        case true: TagContainerView(tags: $tags,
                                      availableWidth: availableWidth,
                                      onSelectTag: onSelectTag)
        case false: EmptyView()
        }
    }
}
