//
//  SectionsView.swift
//  EMSwiftUI
//
//  Created by Halil Yavuz on 17.12.2024.
//

import SwiftUI

struct ExpandableSectionView: View {
    let section: SectionData
    var availableWidth: CGFloat
    let toggleTagSelection: (SectionData, SectionTag) -> Void
    @Binding var selectedTags: [SectionTag]
    @State private var isExpanded: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            HStack {
                Text(section.title)
                    .font(FontFamily.SFProText.regular.swiftUIFont(size: 20))
                
                Spacer()
                
                Button(action: { isExpanded.toggle() }) {
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundStyle(Asset.Colors.grayBase.swiftUIColor)
                }
            }
            .padding(.horizontal, 16)

                if isExpanded {
                    FlexibleGridView(items: section.tags, availableWidth: availableWidth) { tag in
                        TagView(tag: tag.name, isSelected: tag.isSelected)
                            .onTapGesture {
                                toggleTagSelection(section, tag)
                            }
                    }
                    .padding(.horizontal, 16)
                    
                }
            
           
        }
    }
}
