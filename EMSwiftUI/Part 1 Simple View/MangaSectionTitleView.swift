//
//  MangaSectionTitleView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSectionTitleView: View {
    let sectionTitle: String
    
    typealias Const = MangaListMainScreenModel.Const
    
    var body: some View {
        HStack {
            Text(sectionTitle)
                .font(.custom(FontFamily.SFPro.bold,
                              size: Const.Text.largeSize))
            Spacer()
            moreButton
        }
        .foregroundColor(Const.Colors.black)
    }
}

private extension MangaSectionTitleView {
    var moreButton: some View {
        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
            HStack {
                Text(Const.Layout.moreButtonName)
                    .font(.custom(FontFamily.SFPro.regular,
                                  size: Const.Text.mediumSize))
                Asset.Icons.moreIcon.swiftUIImage
            }
        })
    }
}

