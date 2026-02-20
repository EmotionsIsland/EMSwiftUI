//
//  FilterSelectionSectionView.swift
//  EMSwiftUI
//
//  Created by Дарина Самохина on 19.02.2026.
//

import SwiftUI

struct FilterSelectionSectionView: View {
    let selectedTags: [Tag]
    let onTagTap: (String) -> Void
    let resetAction: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 16) {
                Text("Selection")
                    .font(.SFPro.headline3)
                    .foregroundStyle(.blackBase)
                
                FlexibleContainerView(spacing: 8, items: selectedTags) { tag in
                    TagView(title: tag.attributes.name.en ?? "", isSelected: true) {
                        onTagTap(tag.id)
                    }
                }
                
                VStack(alignment: .center, spacing: 8) {
                    Button(action: {}, label: {
                        Text("Apply")
                            .font(.SFPro.mediumNormal)
                            .frame(maxWidth: .infinity)
                            .frame(height: 44)
                            .background(.orangeBase)
                            .foregroundColor(.whiteText)
                            .cornerRadius(8)
                    })
                    
                    Button(action: resetAction, label: {
                        Text("Reset")
                            .font(.SFPro.mediumNormal)
                            .foregroundColor(.blackBase)
                    })
                }
                
                Divider()
                    .background(Color(red: 237/255, green: 238/255, blue: 242/255))
            }
            .padding(.top, 32)
            .padding(.horizontal, 16)
        }
    }
}
