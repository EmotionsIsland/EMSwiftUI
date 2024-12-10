//
//  CollapsibleSection.swift
//  EMSwiftUI
//
//  Created by Иван Незговоров on 10.12.2024.
//


import SwiftUI

@available(iOS 16.0, *)
struct CollapsibleSection: View {
    var title: String
    @Binding var tags: [SelectedTag]
    var onSelect: (SelectedTag) -> Void
    
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
                TagLayout(alignment: .leading, spacing: 8) {
                    ForEach($tags, id: \.self) { $tag in
                        TagView(tag: $tag) { selectTag in
                            onSelect(selectTag)
                        }
                    }
                }
            }
        }
    }
}
