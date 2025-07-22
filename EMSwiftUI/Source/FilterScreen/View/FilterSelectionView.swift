//
//  FilterSelectionView.swift
//  EMSwiftUI
//
//  Created by Новгородцев Никита on 22/07/2025.
//

import SwiftUI

@available(iOS 16.0, *)
struct FilterSelectionView: View {
    var selectionTitle: String
    var tagsSelected: [Tag]
    var isSelectedTag: (Tag) -> Void
    var resetAction: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(selectionTitle)
                .font(.SFPro.headline3)
                .padding(.bottom, 8)
            FlowLayout {
                ForEach(tagsSelected) { tag in
                    FilterTagView(tag: tag,
                                  isSelected: true,
                                  action: { tag in
                        isSelectedTag(tag)
                    })
                }
                .padding(.vertical, 8)
            }
            Button {
                print("Apply")
            } label: {
                Text("Apply")
                    .font(.SFPro.mediumNormal)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.init(cgColor: #colorLiteral(red: 1, green: 0.4928947091, blue: 0.3157388568, alpha: 1)))
                    )
            }
            .padding(.top, 16)
            HStack {
                Spacer()
                Button {
                    resetAction()
                } label: {
                    Text("Reset")
                        .font(.SFPro.mediumNormal)
                        .foregroundColor(.black)
                }
                Spacer()
            }
            .padding(.vertical, 8)
        }
    }
}
