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
        HStack(alignment: .center) {
            Text(title)
                .font(.SFPro.headline3)
            Spacer()
            Text("more")
                .font(.SFPro.bodyNormal)
                .offset(y: -1)
            Image(.moreIcon)
        }
        .foregroundStyle(.blackBase)
    }
}
