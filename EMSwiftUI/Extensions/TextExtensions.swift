//
//  TextExtensions.swift
//  EMSwiftUI
//
//  Created by Kristina Grebneva on 07.03.2025.
//

import SwiftUI

extension Text {
    func oranged() -> some View {
        self
            .font(.custom(FontFamily.SFPro.regular, size: Const.Text.mediumSize))
            .foregroundColor(Asset.Colors.whiteText.swiftUIColor)
            .padding(Const.Layout.largePadding)
            .background(Asset.Colors.orangeBase.swiftUIColor)
            .cornerRadius(Const.Layout.buttonRadius)
    }
}
