//
//  CollapsibleSection.swift
//  EMSwiftUI
//
//  Created by Иван Незговоров on 10.12.2024.
//


import SwiftUI

struct CollapsibleSection: View {
    let title: String
    @Binding var tags: [SelectedTag]
    let onSelect: (SelectedTag) -> Void
    
    @State private var isExpanded = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(title)
                    .font(FontFamily.SFProText.regular.swiftUIFont(fixedSize: 20))
                Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
            }
            .onTapGesture {
                withAnimation {
                    isExpanded.toggle()
                }
            }
            
            if isExpanded {
                TagLayoutView(selectedTags: $tags) { selectTag in
                    onSelect(selectTag)
                }
            }
        }
    }
}
