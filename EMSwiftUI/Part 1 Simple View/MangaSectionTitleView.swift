//
//  MangaSectionTitleView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSectionTitleView: View {
    let title: String
    let moreButton: () -> Void
    var body: some View {
        
        HStack {
            Text(title)
                .font(FontFamily.SFProText.bold.swiftUIFont(size: 20))
            
            Spacer()
            Button(action: { moreButton() }) {
                HStack(spacing: 4) {
                    Text("more")
                        .font(FontFamily.SFProText.medium.swiftUIFont(size: 16))
                        .foregroundStyle(Asset.Colors.blackBase.swiftUIColor)
                    Image(asset: Asset.Icons.moreIcon)
                        .foregroundStyle(Asset.Colors.blackBase.swiftUIColor)
                }
            }
        }
        .padding(.bottom, 16)
    }
}

#Preview {
    MangaSectionTitleView(title: "Popular", moreButton: {})
}
