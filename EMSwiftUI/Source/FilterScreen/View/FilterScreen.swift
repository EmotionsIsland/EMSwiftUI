//
//  FilterScreen.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct FilterScreen<VM: IFilterViewModel>: View {
    @StateObject private var viewModel: VM

    init(viewModel: VM) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ScrollView {
            content
        }
        .padding(16)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text("Filters")
                        .font(Font.SFPro.headline2)

                    Divider()
                        .frame(width: UIScreen.main.bounds.width)
                }
            }
        }
    }

    private var content: some View {
        VStack(alignment: .leading, spacing: 16) {
            selectionTitle
            if !viewModel.selectedTags.isEmpty {
                selectionContent
            }
            selectionButtons
            dropDownMenu
        }
        .padding(.top, 16)
    }

    private var selectionTitle: some View {
        Text("Selection")
            .foregroundStyle(Color.blackBase)
            .font(Font.SFPro.headline3)
    }

    private var selectionContent: some View {
        FlexibleView(
            data: viewModel.selectedTags,
            spacing: 8,
            alignment: HorizontalAlignment.leading
        ) { item in
            filterItem(item)
        }
    }

    private var selectionButtons: some View {
        VStack(alignment: .center, spacing: 0) {
            Button(action: {}) {
                Text("Apply")
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(Color.whiteText)
                    .font(Font.SFPro.mediumNormal)
                    .padding(12)
            }
            .background(Color.orangeBase)
            .clipShape(RoundedRectangle(cornerRadius: 8))

            Button(action: {
                viewModel.selectedTags.removeAll()
            }) {
                Text("Reset")
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(Color.blackBase)
                    .font(Font.SFPro.mediumNormal)
                    .padding(.top, 8)
                    .padding(.bottom, 16)
            }

            Divider()
        }
    }

    private var dropDownMenu: some View {
        VStack(alignment: .leading, spacing: 24) {
            ForEach(viewModel.dropDownContent.indices, id: \.self) { index in
                DropDownView(
                    tagElements: viewModel.dropDownContent[index].tagElements,
                    title: viewModel.dropDownContent[index].title,
                    menuIsPresenting: $viewModel.menuIsPresenting[index],
                    selectedTags: $viewModel.selectedTags
                )
            }
        }
    }

    private func filterItem(_ item: TagItem) -> some View {
        HStack(spacing: 4) {
            Image(.addIcon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20)
                .foregroundStyle(Color.whiteText)

            Text(item.text)
                .foregroundStyle(Color.whiteText)
                .font(Font.SFPro.bodyNormal)
        }
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.orangeBase)
        )
    }
}
