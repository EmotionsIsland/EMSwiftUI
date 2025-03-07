//
//  MangaSectionTitleView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSectionTitleView: View {
    var body: some View {
        HStack {
            Text("SectionTitle")
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
    MangaSectionTitleView()
}
