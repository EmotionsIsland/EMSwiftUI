//
//  FilterCategoryView.swift
//  EMSwiftUI
//
//  Created by Kirill Pukhov on 02.04.2025.
//

import Foundation
import SwiftUI

struct FilterCategoryView: View {
    let category: FilterCategory
    let items: [FilterItem]

    let onSelectAction: (FilterItem) -> Void

    @State private var isExpanded = false

    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Button {
                    isExpanded.toggle()
                } label: {
                    HStack(spacing: 8) {
                        Text(category.title)
                            .font(.SFPro.regularLarge)
                            .foregroundStyle(.black)

                        Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                            .foregroundStyle(.black)
                            .frame(width: 24, height: 24)
                    }
                }

                Spacer()
            }

            if isExpanded {
                FlexibleLayout(items, id: \.id, spacing: 8) { item in
                    HStack {
                        if item.isSelected {
                            Image(systemName: "plus")
                                .foregroundStyle(.whiteText)
                                .transition(.opacity)
                        }

                        Text(item.name)
                            .lineLimit(1)
                            .font(.SFPro.bodyNormal)
                            .foregroundStyle(item.isSelected ? .whiteText : .black)
                    }
                    .padding(8)
                    .background(item.isSelected ? .orangeBase : .grayBase.opacity(0.25))
                    .cornerRadius(8)
                    .onTapGesture {
                        onSelectAction(item)
                    }
                }
            }
        }
    }
}
