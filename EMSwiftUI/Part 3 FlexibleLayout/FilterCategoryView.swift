//
//  FilterCategoryView.swift
//  EMSwiftUI
//
//  Created by Денис Хафизов on 13.10.2024.
//

import SwiftUI

struct FilterCategoryView: View {
    @Binding var selectedTags: [String]
    
    let title: String
    let tags: [String]
    
    var toggleTag: (String) -> Void
    
    var body: some View {
        
        DisclosureGroup(title) {
            FlexibleTagView(selectedTags: $selectedTags, items: tags, toggleTag: toggleTag)
        }
        .font(.custom(FontFamily.SFPro.regular, size: 16))
        .accentColor(.blackBase)
    }
}
