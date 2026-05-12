//
//  MangaSectionTitleView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSectionTitleView: View {
    let title: String

    var body: some View {
        HStack {
            Text(title)
                .font(.SFPro.headline3)
                .foregroundStyle(.blackBase)

            Spacer()

            HStack(spacing: 8) {
                Text("more")
                    .font(.SFPro.bodyNormal)

                Image(.moreIcon)
            }
            .foregroundStyle(.blackBase)
        }
    }
}
