//
//  CustomizedButton.swift
//  EMSwiftUI
//
//  Created by Alex on 5.05.24.
//

import SwiftUI

struct CustomizedButton: View {
    var text: LocalizedStringKey?
    var image: ImageResource?
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack(alignment: .center, spacing: 4){
                if let image = image {
                    Image(image)
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 24, height: 24)
                }
                if let text = text {
                    Text(text)
                        .font(.custom(FontFamily.SFPro.regular, size: 14))
                }
            }
                .foregroundStyle(.grayBase)
                .padding(.horizontal, 4)
                .frame(minHeight: 36)
                .frame(minWidth: 36)
        }
        .background(.whiteText, in: .rect(cornerRadius: 8))
    }
}

#Preview {
    CustomizedButton(image: .filterIcon){
        
    }
}
