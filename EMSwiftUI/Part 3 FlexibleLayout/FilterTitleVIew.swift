//
//  FilterTitleVIew.swift
//  EMSwiftUI
//
//  Created by Никита Гладышев on 21.07.2024.
//

import SwiftUI

struct FilterTitleView: View {
    var body: some View {
        VStack {
            ZStack {
                titleLabel
                
                closeButton
            }
            
            divider
        }
    }
}

private extension FilterTitleView {
    var titleLabel: some View {
        HStack {
            Text("Filters")
                .font(FontFamily.SFPro.bold.swiftUIFont(size: 24))
                .foregroundStyle(.blackBase)
        }
    }
    
    var closeButton: some View {
        Button {
            print("tap")
        } label: {
            Image(systemName: "xmark")
                .resizedToFill(width: 20, height: 20)
                .scaledToFill()
                .foregroundStyle(.blackBase)
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    var divider: some View {
        Divider()
            .foregroundStyle(.gray)
    }
}
