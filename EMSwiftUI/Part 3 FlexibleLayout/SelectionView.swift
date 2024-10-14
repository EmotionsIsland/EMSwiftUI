//
//  SelectionView.swift
//  EMSwiftUI
//
//  Created by Денис Хафизов on 13.10.2024.
//

import SwiftUI

struct SelectionView: View {
    @Binding var selectedTags: [String]
    
    var toggleTag: (String) -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Selection")
                .font(.headline)
            
            FlexibleGridView(selectedTags: $selectedTags, items: selectedTags, isSelectable: false, toggleTag: toggleTag)
        }
    }
}
