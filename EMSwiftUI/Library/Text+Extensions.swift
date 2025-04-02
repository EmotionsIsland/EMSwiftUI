//
//  Text+Extensions.swift
//  EMSwiftUI
//
//  Created by Антон Баландин on 1.04.25.
//

import SwiftUI

extension Text {
    typealias Const = MangaListMainScreenModel.Const

    func oranged() -> some View {
        self
            .foregroundColor(Color.whiteText)
            .font(Font.SFPro.bodyNormal)
            .padding(Const.Layout.largePadding)
            .background(Color.orangeBase)
            .cornerRadius(Const.Layout.buttonRadius)
    }
}
