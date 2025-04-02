//
//  OrangeButtonStyle.swift
//  EMSwiftUI
//
//  Created by Антон Баландин on 1.04.25.
//

import SwiftUI

struct OrangeButtonStyle: ViewModifier {
   let color: Color
    
    typealias Const = MangaListMainScreenModel.Const

    func body(content: Content) -> some View {
        content
            //.font(.custom(FontFamily.SFPro.regular, size: Const.Text.mediumSize))
            //.foregroundColor(Asset.Colors.whiteText.swiftUIColor)
            .padding(Const.Layout.largePadding)
            .background(color)
            .cornerRadius(Const.Layout.buttonRadius)
    }
}

extension View {
    func orangeButtonStyle(color: Color) -> some View {
        self.modifier(OrangeButtonStyle(color: color))
    }
}
