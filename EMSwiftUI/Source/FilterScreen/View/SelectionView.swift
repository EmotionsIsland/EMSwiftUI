//
//  SelectionView.swift
//  EMSwiftUI
//
//  Created by Денис Ефименков on 11.02.2026.
//

import SwiftUI

struct SelectionView: View {
    let selected: [FilterTag]
    let onTap: (FilterTag) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Selection")
                .font(.system(size: 20, weight: .bold))

            if selected.isEmpty {
                Text("No filters selected")
                    .foregroundColor(.grayBase)
                    .font(.system(size: 14))
            } else {
                TagChipsGrid(
                    tags: selected,
                    isSelected: { _ in true },
                    onTap: onTap
                )
            }
        }
    }
}
