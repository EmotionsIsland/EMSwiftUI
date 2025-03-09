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
                .font(FontFamily.SFPro.bold.swiftUIFont(size: 20))
                .foregroundStyle(.blackBase)
            Spacer()
            Button {
                print("Open genre list")
            } label: {
                HStack(alignment: .top, spacing: 8) {
                    Text("more")
                        .foregroundStyle(.blackBase)
                    Image(.moreIcon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(.blackBase)
                }
            }

        }
    }
}

#Preview {
    MangaSectionTitleView(title: "Manga title")
}
