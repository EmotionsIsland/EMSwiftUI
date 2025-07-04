//
//  TagView.swift
//  EMSwiftUI
//
//  Created by Ruslan on 25.06.2025.
//

import SwiftUI

struct TagView: View {
    let name: String
    
    let isSelected: Bool

    let action: (Bool) -> Void
    
    var body: some View {
        HStack {
            Text(isSelected ? "+" : "")
            .font(Font.SFPro.regularLarge)
            
            Text(name)
                .font(Font.SFPro.regularLarge)
        }
        .padding(5)
        .background(isSelected ? Color.orangeBase : Color.grayBase)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .foregroundStyle(isSelected ? Color.white : Color.black)
        .onTapGesture {
                action(isSelected)
        }
    }
}
