//
//  TagChipView.swift
//  EMSwiftUI
//
//  Created by Алсу Хайруллина on 14.10.2024.
//

import SwiftUI

struct TagChipView: View {
    
    @Binding var tag: TagChipModel
    let onTagToggle: (TagChipModel, Bool) -> Void
    
    var body: some View {
        HStack(spacing: 4) {
            if tag.isSelected {
                Image(systemName: "plus")
            }
            Text(tag.title)
        }
        .frame(maxHeight: 22)
        .fixedSize()
        .padding(8)
        .foregroundColor(tag.isSelected ? .white : .black)
        .background(tag.isSelected ? Color.orangeBase : Color.grayBase.opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .onTapGesture {
            self.tag.isSelected.toggle()
            onTagToggle(tag, self.tag.isSelected)
        }
    }
}
