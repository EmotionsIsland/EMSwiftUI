//
//  TagView.swift
//  EMSwiftUI
//
//  Created by Иван Незговоров on 10.12.2024.
//

import SwiftUI

struct TagView: View {
    @Binding var tag: SelectedTag
    var onTap: (SelectedTag) -> Void
    
    var body: some View {
        Text(tag.text)
            .font(FontFamily.SFProText.regular.swiftUIFont(fixedSize: 16))
            .padding(8)
            .background(tag.select ? Asset.Colors.orangeBase.swiftUIColor: Asset.Colors.grayBase.swiftUIColor)
            .foregroundColor(tag.select ? Asset.Colors.whiteText.swiftUIColor: Asset.Colors.blackBase.swiftUIColor)
            .cornerRadius(8)
            .lineLimit(1)
            .onTapGesture {
                tag.select.toggle()
            
                if tag.select {
                    tag.text = "+ " + tag.text
                } else {
                    tag.text.removeFirst(2)
                }
                onTap(tag)
            }
    }
}
