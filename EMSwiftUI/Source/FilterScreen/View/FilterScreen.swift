//
//  FilterScreen.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct FilterScreen<VM: FilterScreenViewModelProtocol>: View {
    @StateObject private var viewModel: VM

    init(viewModel: VM) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 32) {
                    Color(.grayBase)
                        .frame(height: 1)

                    VStack(alignment: .leading, spacing: 16) {
                        if !viewModel.selectedFilters.isEmpty {
                            makeSelectionView()
                        }
                        makeGroupsView()
                    }
                    .padding(.horizontal, 16)
                }
            }
            .navigationTitle("Filters")
            .navigationBarBackButtonHidden()
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(false)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {} label: {
                        Image(.close)
                            .tint(Color.blackBase)
                    }
                }
            }
        }
    }
}

private extension FilterScreen {
    func makeSelectionView() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Selection")
                .font(.SFPro.headline3)
                .foregroundStyle(Color.blackBase)
            FlexibleView(
                data: viewModel.selectedFilters,
                spacing: 8,
                alignment: HorizontalAlignment.leading
            ) { filter in
                Button {
                    viewModel.filterSelected(with: filter)
                } label: {
                    makeFilterButton(with: filter, isActive: true)
                }
                .animation(.easeInOut, value: viewModel.selectedFilters)
            }

            makeSelectionButtons()

            Color(.whiteText)
                .frame(height: 1)
        }
    }

    func makeSelectionButtons() -> some View {
        VStack(alignment: .center, spacing: 8) {
            Button {
                viewModel.applyFilters()
            } label: {
                Text("Apply")
                    .font(.SFPro.bodyNormal)
                    .foregroundStyle(Color.whiteText)
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .background(Color.orangeBase)
            .clipShape(.rect(cornerRadius: 8))

            Button {
                viewModel.resetFilters()
            } label: {
                Text("Reset")
                    .font(.SFPro.bodyNormal)
                    .foregroundStyle(Color.blackBase)
            }
        }
    }

    @ViewBuilder
    func makeGroupsView() -> some View {
        VStack(alignment: .leading, spacing: 24) {
            ForEach(viewModel.filterGroups, id: \.self) { group in
                Button {
                    viewModel.groupSelected(with: group.title)
                } label: {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack(alignment: .center, spacing: 8) {
                            Text(group.title)
                                .font(.SFPro.regularLarge)
                                .foregroundStyle(Color.blackBase)
                            Image(.expandDown)
                                .rotationEffect(.degrees(viewModel.openedGroups.contains(group.title) ? 180 : 0))
                                .tint(Color.blackBase)
                        }
                        if viewModel.openedGroups.contains(group.title) {
                            FlexibleView(
                                data: group.filters,
                                spacing: 8,
                                alignment: HorizontalAlignment.leading
                            ) { filter in
                                makeFilterButton(with: filter, isActive: viewModel.selectedFilters.contains(filter))
                            }
                        }
                    }
                    .animation(nil)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    func makeFilterButton(with title: String, isActive: Bool) -> some View {
        Button {
            viewModel.filterSelected(with: title)
        } label: {
            HStack(alignment: .center, spacing: 4) {
                Image(.addRound)
                    .tint(Color.whiteText)
                Text(title)
                    .font(.SFPro.bodyNormal)
                    .foregroundStyle(Color.whiteText)
            }
            .padding(8)
            .background(isActive ? Color.orangeBase : Color.grayBase)
        }
        .clipShape(.rect(cornerRadius: 8))
    }
}
