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
                .font(Font.SFPro.headline3)
                .foregroundStyle(.blackBase)
            Spacer()
            Button(
                action: {},
                label: {
                    HStack(alignment: .top, spacing: 8) {
                        Text("more")
                            .foregroundStyle(.blackBase)
                            .font(Font.SFPro.bodyNormal)
                        Image(.moreIcon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundStyle(.blackBase)
                    }
                }
            )
        }
    }
}

#Preview {
    MangaSectionTitleView(title: "Manga Section")
}
