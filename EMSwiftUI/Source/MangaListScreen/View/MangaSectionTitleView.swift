//
//  MangaSectionTitleView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSectionTitleView: View {
    private let header: String

    init(header: String) {
        self.header = header
    }

    var body: some View {
        HStack {
            Text(header)
                .foregroundStyle(Color.blackBase)
                .font(Font.SFPro.headline3)
            Spacer()
            Button(action: {}) {
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
            }
        }
    }
}
