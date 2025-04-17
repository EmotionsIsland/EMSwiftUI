//
//  FilterScreen.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct FilterScreen<VM: FilterViewModel>: View {
    @StateObject private var viewModel: VM

    init(viewModel: VM) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationView {
            ScrollView {
                content
            }
            .padding(16)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Filters")
                        .font(Font.SFPro.headline2)
                }
            }
        }
    }
}

private extension FilterScreen {
    var content: some View {
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

    var selectionTitle: some View {
        Text("Selection")
            .foregroundStyle(Color.blackBase)
            .font(Font.SFPro.headline3)
    }

    var selectionContent: some View {
        FlexibleView(
            data: viewModel.selectedTags,
            spacing: 8,
            alignment: HorizontalAlignment.leading
        ) { item in
            filterItem(item)
        }
    }

    var selectionButtons: some View {
        VStack(alignment: .center, spacing: 0) {
            Button(action: {}, label: {
                Text("Apply")
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(Color.whiteText)
                    .font(Font.SFPro.mediumNormal)
                    .padding(12)
            })
            .background(Color.orangeBase)
            .clipShape(RoundedRectangle(cornerRadius: 8))

            Button(action: viewModel.removeAllSelectedTags,
                   label: {
                Text("Reset")
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(Color.blackBase)
                    .font(Font.SFPro.mediumNormal)
                    .padding(.top, 8)
                    .padding(.bottom, 16)
            })

            Divider()
        }
    }

    var dropDownMenu: some View {
        VStack(alignment: .leading, spacing: 24) {
            ForEach(viewModel.dropDownContent.indices, id: \.self) { index in
                DropDownView(
                    title: viewModel.dropDownContent[index].title,
                    tagElements: viewModel.dropDownContent[index].tagElements,
                    selectedTags: viewModel.selectedTags,
                    onMenuItem: viewModel.addSelectedTag
                )
            }
        }
    }

    func filterItem(_ item: TagItem) -> some View {
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
