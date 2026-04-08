//
//  CategoriesSectionView.swift
//  EMSwiftUI
//
//  Created by Анатолий Чириков on 24.03.2026.
//

import SwiftUI

struct CategoriesSectionView: View {
    let groupTags: [String: [Tag]]
    let selectedTagsIDs: Set<String>
    let onTagTap: (String) -> Void
    let sortedKeys: [String]
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(sortedKeys, id: \.self) { key in
                DisclosureGroup {
                    if let tagsForGroup = groupTags[key] {
                        FlexibleLayout(data: tagsForGroup, spacing: 8) { tag in
                            TapPillView(title: tag.attributes.name.en ?? "",
                                        isSelected: selectedTagsIDs.contains(tag.id),
                                        action: { onTagTap(tag.id)})
                        }
                        .padding(.top, 12)
                        .padding(.bottom, 16)
                    }
                } label: {
                    Text(FilterScreenViewModelImpl.formatTitle(key))
                        .font(Font.SFPro.semiboldNormal)
                        .foregroundStyle(Color.blackBase)
                }
                .padding(16)
                .accentColor(Color.blackBase)
            }
        }
        .animation(.easeInOut, value: selectedTagsIDs)
    }
}
