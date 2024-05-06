//
//  FilterOptionView.swift
//  EMSwiftUI
//
//  Created by Alex on 5.05.24.
//

import SwiftUI

struct FilterOptionView: View {
    var isSelected: Bool
    var text: String
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack(alignment: .center, spacing: 8) {
                if isSelected {
                    Image(systemName: "plus")
                        .font(.system(size: 20))
                }
                Text(text)
                    .font(.custom(FontFamily.SFPro.regular, size: 16))
            }
            .frame(height: 20, alignment: .center)
            .padding(8)
            .background(isSelected ? .orangeBase : .grayBase, in: .rect(cornerRadius: 8))
            .foregroundStyle(isSelected ? .white : .black )
        }
    }
}

#Preview {
    VStack {
        FilterOptionView(isSelected: true, text: "Completed") { }
        FilterOptionView(isSelected: false, text: "Completed") { }
    }
}
