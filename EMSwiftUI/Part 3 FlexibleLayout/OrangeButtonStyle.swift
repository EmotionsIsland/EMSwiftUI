//
//  RedButtonStyle.swift
//  EMSwiftUI
//
//  Created by Kristina Grebneva on 07.03.2025.
//

import SwiftUI

struct OrangeButtonStyle: ViewModifier {
   let color: Color
    
    typealias Const = MangaListMainScreenModel.Const

    func body(content: Content) -> some View {
        content
            .font(.custom(FontFamily.SFPro.regular, size: Const.Text.mediumSize))
            .foregroundColor(Asset.Colors.whiteText.swiftUIColor)
            .padding(Const.Layout.largePadding)
            .background(color)
            .cornerRadius(Const.Layout.buttonRadius)
    }
}

