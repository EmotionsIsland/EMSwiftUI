//
//  TagView.swift
//  EMSwiftUI
//
//  Created by Halil Yavuz on 17.12.2024.
//

import SwiftUI

struct TagView: View {
    let tag: String
    let isSelected: Bool
    
    var body: some View {
        HStack {
            if isSelected {
                Image(systemName: "plus")
            }
            Text(tag)
                .font(FontFamily.SFProText.regular.swiftUIFont(size: 16))
    }
        .padding(8)
        .foregroundStyle(isSelected ? Asset.Colors.whiteText.swiftUIColor : Asset.Colors.blackBase.swiftUIColor)
        .background(isSelected ? Asset.Colors.orangeBase.swiftUIColor : Asset.Colors.grayBase.swiftUIColor)
        .clipShape(RoundedRectangle(cornerRadius: 8))
}
    
}

#Preview {
    TagView(tag: "Completed", isSelected: true)
}
