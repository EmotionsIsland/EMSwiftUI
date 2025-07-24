//
//  FilterSelectionView.swift
//  EMSwiftUI
//
//  Created by Новгородцев Никита on 22/07/2025.
//

import SwiftUI

struct FilterSelectionView: View {
    let model: FilterSelectionModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(model.category)
                .font(.SFPro.headline3)
                .padding(.bottom, 8)
            FlowLayout(items: model.selectedTags, spacing: 8) { tag in
                FilterTagView(tag: tag,
                              isSelected: true,
                              action: { tappedTag in
                    model.onTagSelect(tappedTag)
                })
            }
            .padding(.vertical, 8)
            Button {
                print("Apply")
            } label: {
                Text("Apply")
                    .font(.SFPro.mediumNormal)
                    .foregroundColor(Color.whiteText)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.orangeBase)
                    )
            }
            .padding(.top, 16)
            HStack {
                Spacer()
                Button {
                    model.onReset()
                } label: {
                    Text("Reset")
                        .font(.SFPro.mediumNormal)
                        .foregroundColor(Color.blackBase)
                }
                Spacer()
            }
            .padding(.vertical, 8)
        }
    }
}
