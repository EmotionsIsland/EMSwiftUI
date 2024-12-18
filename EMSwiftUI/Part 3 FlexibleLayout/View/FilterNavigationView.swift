//
//  FilterNavigationView.swift
//  EMSwiftUI
//
//  Created by Максим Шишлов on 18.12.2024.
//

import SwiftUI

struct FilterNavigationView: View {
    var body: some View {
        VStack(spacing: 8) {
            navigationTitle
            
            navigationDivider
        }
    }
}

extension FilterNavigationView {
    
    private var navigationTitle: some View {
        Text("Filters")
            .font(.custom(FontFamily.SFProText.bold, size: 24))
            .hSpacing()
            .foregroundStyle(.blackBase)
            .overlay(alignment: .trailing) {
                Image(systemName: "xmark")
                    .frame(width: 30, height: 30)
                    .foregroundStyle(.blackBase)
                    .padding(.horizontal, 16)
            }
    }
    
    private var navigationDivider: some View {
        Rectangle()
            .hSpacing()
            .frame(height: 1)
            .foregroundStyle(.grayBase)
    }
    
}
