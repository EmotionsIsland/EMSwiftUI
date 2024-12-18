//
//  SearchBarView.swift
//  EMSwiftUI
//
//  Created by Halil Yavuz on 16.12.2024.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var inputText: String
    var body: some View {
        HStack {
            Image(asset: Asset.Icons.magnifyingglassIcon)
                .resizable()
                .frame(width: 18 , height: 18)
                .padding(.leading, 8)
            
            TextField("Search", text: $inputText)
                .textFieldStyle(PlainTextFieldStyle())
        }
        .frame(height: 38)
        .background(Asset.Colors.lightGrayBase.swiftUIColor)
        .cornerRadius(8)
    }
}


