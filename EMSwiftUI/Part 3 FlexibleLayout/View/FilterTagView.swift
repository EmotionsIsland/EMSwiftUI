//
//  FilterTagView.swift
//  EMSwiftUI
//
//  Created by Максим Шишлов on 18.12.2024.
//

import SwiftUI

struct FilterTagView: View {
    
    let tag: FilterTag
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "plus")
            Text(tag.name)
        }
        .padding(8)
        .background(.orangeBase, in: RoundedRectangle(cornerRadius: 8))
        .foregroundStyle(.white)
        .font(.custom(FontFamily.SFProText.regular, size: 16))
    }
}
