//
//  FilterScreen.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct FilterScreen<ViewModel: FilterScreenViewModelProtocol>: View {
    @StateObject var viewModel: ViewModel

    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 16) {
                Text("Selection")
                    .font(.SFPro.headline3)
                    .foregroundStyle(.blackBase)

                FlexibleLayout(viewModel.selectedItems, id: \.id, spacing: 8) { item in
                    HStack {
                        if item.isSelected {
                            Image(systemName: "plus")
                                .foregroundStyle(.whiteText)
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
                        viewModel.selectItem(item)
                    }
                }

                VStack(spacing: 8) {
                    Button(action: viewModel.applySelction) {
                        Text("Apply")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(.orangeBase)
                            .cornerRadius(10)
                            .foregroundColor(.white)
                    }

                    Button(action: viewModel.resetSelection) {
                        Text("Reset")
                            .foregroundColor(.black)
                            .padding()
                    }
                }
            }
            .padding(.horizontal)

            LazyVStack(spacing: 24) {
                ForEach(FilterCategory.allCases, id: \.self) {
                    FilterCategoryView(
                        category: $0,
                        items: viewModel.getItems(for: $0),
                        onSelectAction: viewModel.selectItem
                    )
                }
            }
            .padding(.horizontal)
        }
        .task {
            await viewModel.fetchItems()
        }
    }
}

#Preview {
    FilterScreenBuilder.build()
}
