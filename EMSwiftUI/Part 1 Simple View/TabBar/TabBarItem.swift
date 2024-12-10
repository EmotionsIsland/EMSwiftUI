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
            VStack(spacing: 0) {  // Убираем отступы между элементами
                Image(asset: icon)
                    .resizable()
                    .scaledToFill()  // Масштабирование изображения без искажения
                    .frame(width: 40, height: 40)  // Фиксированные размеры
                    .clipped()
                if !title.isEmpty {  // Показываем текст только если он есть
                    Text(title)
                        .font(FontFamily.SFPro.regular.swiftUIFont(size: 14))
                        .foregroundColor(Asset.Colors.orangeBase.swiftUIColor)
                }
            }
        }
    }
}
