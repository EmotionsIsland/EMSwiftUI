//
//  FiltersView.swift
//  EMSwiftUI
//
//  Created by Никита Гладышев on 22.07.2024.
//

import SwiftUI

struct FiltersView: View {
    let title: String
    let isOpened: Bool
    
    var body: some View {
        HStack(spacing: 8) {
            Text(title)
                .font(FontFamily.SFPro.regular.swiftUIFont(fixedSize: 20))
                .foregroundStyle(.blackBase)
            
            Image(systemName: isOpened ? "chevron.up" : "chevron.down")
                .resizedToFill(width: 12, height: 6)
                .foregroundStyle(.blackBase)
        }
    }
}


