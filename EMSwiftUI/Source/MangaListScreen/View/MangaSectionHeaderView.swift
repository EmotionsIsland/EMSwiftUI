//
//  MangaSectionHeaderView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSectionHeaderView: View {
    @Environment(\.mangaListSection) var section

    var body: some View {
        HStack(alignment: .top) {
            Text(section?.title ?? "Section Title")
                .lineLimit(1)
                .font(.SFPro.mediumNormal)
                .foregroundStyle(.blackBase)

            Spacer(minLength: 32)

            HStack(alignment: .top, spacing: 8) {
                Text("more")
                    .font(.SFPro.bodyNormal)
                    .foregroundStyle(.blackBase)

                Image(.moreIcon)
                    .renderingMode(.template)
                    .foregroundStyle(.blackBase)
                    .frame(width: 24, height: 24)
            }
        }
    }
}
