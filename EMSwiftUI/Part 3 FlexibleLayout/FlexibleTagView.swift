//
//  FlexibleTagView.swift
//  EMSwiftUI
//
//  Created by Денис Хафизов on 15.10.2024.
//

import SwiftUI

struct FlexibleTagView: View {
    @Binding var selectedTags: [String]
    
    let items: [String]
    var isSelectable: Bool = true
    var toggleTag: (String) -> Void
    
    var body: some View {
        FlowLayout(selectedTags: $selectedTags, items: items, isSelectable: isSelectable, toggleTag: toggleTag)
    }
}
