//
//  DropDownTagsView.swift
//  EMSwiftUI
//
//  Created by Алсу Хайруллина on 14.10.2024.
//

import SwiftUI

struct DropDownTagsView: View {
    
    @State private var isExpanded = false
    @Binding var tags: [TagChipModel]
    
    let title: String
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
        .animation(.easeInOut(duration: 0.3), value: isExpanded)
    }
}

private extension DropDownTagsView {
    
    var dropButton: some View {
        Button {
            withAnimation {
                isExpanded.toggle()
            }
        } label: {
            Image(systemName: "chevron.up")
                .rotationEffect(.degrees(isExpanded ? 0 : 180))
                .animation(.easeInOut(duration: 0.3), value: isExpanded)
        }
        .foregroundStyle(.black)
        
    }
    
    @ViewBuilder
    var expandedView: some View {
        if isExpanded {
            TagContainerView(tags: $tags,
                             availableWidth: availableWidth,
                             onSelectTag: onSelectTag)
            .transition(.move(edge: .top).combined(with: .opacity))
        }
    }
}
