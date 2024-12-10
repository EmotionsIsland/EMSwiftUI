//
//  MangaSectionTitleView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSectionTitleView: View {
    var title: String
    var onMoreTapped: () -> ()
    var body: some View {
        HStack {
            Text(title)
                .font(FontFamily.SFPro.bold.swiftUIFont(size: 20))
            Spacer()
            Button(action: {
                onMoreTapped()
            }) {
                HStack(spacing: 4) {
                    Text("more")
                        .font(FontFamily.SFPro.medium.swiftUIFont(size: 16))
                        .foregroundColor(Asset.Colors.blackBase.swiftUIColor)
                    Image(asset: Asset.Icons.moreIcon)
                        .foregroundColor(Asset.Colors.blackBase.swiftUIColor)
                }
            }
        }
        .padding(.bottom, 16)
    }
}


//
//#Preview {
//    MangaSectionTitleView()
//}
