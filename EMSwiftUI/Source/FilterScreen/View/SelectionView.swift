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

            ZStack(alignment: .leading) {
                TagChipsGrid(
                    tags: selected,
                    isSelected: { _ in true },
                    onTap: onTap
                )
                .opacity(selected.isEmpty ? 0 : 1)
                
                Text("No filters selected")
                    .foregroundColor(.grayBase)
                    .font(.system(size: 14))
                    .opacity(selected.isEmpty ? 1 : 0)
            }
        }
    }
}
