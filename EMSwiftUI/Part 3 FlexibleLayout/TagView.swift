//
//  FilterButton.swift
//  EMSwiftUI
//
//  Created by Evgenii Mikhailov on 14.03.2025.
//

import SwiftUI

struct TagView: View {
    let tag: Tag
    @ObservedObject var viewModel: FilterViewModel
    var body: some View {
        Button {
            withAnimation {
                viewModel.toggleSelection(for: tag)
            }
        } label: {
            HStack {
                if tag.isSelected ?? false {
                    Image(systemName: "plus")
                        .frame(width: 18, height: 18)
                }
                Text(tag.attributes?.name.en ?? "")
                    .font(.custom(FontFamily.SFPro.regular, size: 16))
                    .lineLimit(1)
            }
            .foregroundStyle(.white)
            .padding(8)
            .background(tag.isSelected ?? false ? .orangeBase : .grayBase)
            .cornerRadius(8)
        }
       
    }
}
