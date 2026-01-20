//
//  MangaSectionView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSectionView: View {
    let title: String
    var body: some View {
        HStack {
            Text(title)
                .font(.SFPro.headline3)
            Spacer()
            Button {
            } label: {
                HStack {
                    Text("more")
                        .font(.SFPro.bodyNormal)
                    Image(.moreIcon)
                }
                .foregroundStyle(.blackBase)
            }
        }
    }
}
#Preview {
    MangaSectionView(title: "Popular")
}
