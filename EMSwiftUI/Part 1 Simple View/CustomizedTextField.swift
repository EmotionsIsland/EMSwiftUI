//
//  CustomizedTextField.swift
//  EMSwiftUI
//
//  Created by Alex on 5.05.24.
//

import SwiftUI

struct CustomizedTextField: View {
    @Binding var text: String
    var placeholder: LocalizedStringKey = ""
    var placeholderImage: ImageResource?
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 8)
                .foregroundStyle(.whiteText)
            
            HStack(alignment: .center, spacing: 4){
                if let image = placeholderImage {
                    Image(image)
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 24, height: 24)
                }
                if text == "" {
                    Text(placeholder)
                        .font(.custom(FontFamily.SFPro.regular, size: 14))
                }
            }.foregroundStyle(.grayBase)
                .padding(.horizontal, 4)
            TextField(text: $text) {
                
            }
                .font(.custom(FontFamily.SFPro.regular, size: 14))
                .padding(.horizontal, 4)
                .padding(.leading, placeholderImage == nil ? 0 : 28)
        }
            .frame(height: 36)
    }
}

#Preview {
    @State var t = ""
    
    return CustomizedTextField(text: $t, placeholder: "Search", placeholderImage: .starIcon)
    
}
