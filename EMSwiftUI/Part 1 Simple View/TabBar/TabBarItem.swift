//
//  TabBarItem.swift
//  EMSwiftUI
//
//  Created by Иван Незговоров on 10.12.2024.
//


import SwiftUI

struct TabBarItem: View {
    let icon: ImageAsset
    let title: String
    @Binding var selectedTab: Int
    let tab: Int
    
    var body: some View {
        Button(action: {
            selectedTab = tab
        }) {
            VStack(spacing: 0) {
                Image(asset: icon)
                    .resizedToFill(width: 40, height: 40)
                    .clipped()
                if !title.isEmpty {
                    Text(title)
                        .font(FontFamily.SFPro.regular.swiftUIFont(size: 14))
                        .foregroundColor(Asset.Colors.orangeBase.swiftUIColor)
                }
            }
        }
    }
}
