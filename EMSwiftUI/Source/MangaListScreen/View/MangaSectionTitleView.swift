//
//  MangaSectionTitleView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSectionTitleView: View {
    let title: String
    let actionTitle: String
    let onTapMore: () -> Void

    init(
        title: String,
        actionTitle: String = "more",
        onTapMore: @escaping () -> Void
    ) {
        self.title = title
        self.actionTitle = actionTitle
        self.onTapMore = onTapMore
    }

    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(title)
                .font(.title3)
                .fontWeight(.semibold)

            Spacer()

            Button(action: onTapMore) {
                HStack(spacing: 6) {
                    Text(actionTitle)
                        .font(.subheadline)
                    Image("moreIcon")
                        .font(.subheadline)
                }
            }
            .buttonStyle(.plain)
            .foregroundStyle(.secondary)
        }
        .padding(.horizontal, 16)
        .padding(.top, 8)
        .padding(.bottom, 6)
    }
}
