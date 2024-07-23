//
//  SearchView.swift
//  EMSwiftUI
//
//  Created by Никита Гладышев on 22.07.2024.
//

import SwiftUI

struct SearchView: View {
    @State var text = ""
    
    var body: some View {
        VStack(spacing: 8) {
            textFieldView
            
            divider
        }
    }
}

private extension SearchView {
    var textFieldImage: some View {
        Image(systemName: "magnifyingglass")
            .resizedToFill(width: 18, height: 18)
            .foregroundStyle(.grayBase)
            .padding(.leading, 7)
    }
    
    var textField: some View {
        TextField("Search", text: $text)
            .frame(height: 36)
            .cornerRadius(8)
            .font(FontFamily.SFPro.light.swiftUIFont(size: 14))
            .foregroundStyle(.grayBase)
    }
    
    var textFieldView: some View {
        HStack(spacing: 7) {
            textFieldImage
            
            textField
        }
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(.grayBase.opacity(0.3))
        )
    }
    
    var divider: some View {
        Divider()
            .background(.gray)
    }
}
