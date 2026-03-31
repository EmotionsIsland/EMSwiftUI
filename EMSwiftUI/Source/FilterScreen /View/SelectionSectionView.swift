//
//  SelectionSectionView.swift
//  EMSwiftUI
//
//  Created by Анатолий Чириков on 24.03.2026.
//

import SwiftUI

struct SelectionSectionView: View {
    let selectedTags: [Tag]
    let onTagTap: (String) -> Void
    let onReset: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Selection")
                .font(Font.SFPro.headline2)
            
            if !selectedTags.isEmpty {
                FlexibleLayout(data: selectedTags, spacing: 8) { tag in
                    TapPillView(title: tag.attributes.name.en ?? "",
                                isSelected: true,
                                action: { onTagTap(tag.id)})
                }
            } else {
                Text("No tags selected")
                    .foregroundStyle(Color.grayBase)
                    .font(.subheadline)
            }
            Buttons(onReset: onReset)
        }
        .padding()
    }
}
