//
//  MangaSectionTitleView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSectionTitleView: View {
    let header: String

    var body: some View {
        HStack {
            Text(header)
                .foregroundStyle(Color.blackBase)
                .font(Font.SFPro.headline3)
            Spacer()
            Button(action: {}, label: {
                HStack(spacing: 4) {
                    Text("more")
                        .foregroundStyle(Color.blackBase)
                        .font(Font.SFPro.bodyNormal)
                    Image(.moreIcon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                        .foregroundStyle(Color.blackBase)
                }
            })
        }
    }
}
