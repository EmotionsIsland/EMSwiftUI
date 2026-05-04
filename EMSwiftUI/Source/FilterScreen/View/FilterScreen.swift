//
//  FilterScreen.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct FilterScreen<ViewModel: FilterViewModel>: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var viewModel: ViewModel

    var body: some View {
        VStack(spacing: 0) {
            header

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    selectionView

                    Divider()

                    ForEach(viewModel.groupedTags.keys.sorted(), id: \.self) { group in
                        groupView(group: group)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
            }


        }
        .task {
            viewModel.onAppear()
        }
    }

    private var header: some View {
        VStack(spacing: 0) {
            ZStack {
                Text("Filters")
                    .font(.SFPro.headline2)
                    .foregroundStyle(.blackBase)

                HStack {
                    Spacer(minLength: 0)
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundStyle(.grayBase)
                    }
                }
            }
            .frame(minHeight: 44)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)

            Divider()
                .background(Color.grayBase.opacity(0.3))
        }
        .padding(.bottom, 16)
        .background(Color.white)
    }

    private var selectionView: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Selection")
                .font(.SFPro.headline2)
                .foregroundStyle(.blackBase)

            FlexibleLayout(data: Array(viewModel.selectedTags), spacing: 8) { tag in
                tagView(tag, isSelected: true)
            }

            Button(action: {
                viewModel.apply()
            }) {
                Text("Apply")
                    .font(.SFPro.mediumNormal)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color.orangeBase)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }

            Button(action: {
                viewModel.reset()
            }) {
                Text("Reset")
                    .font(.SFPro.mediumNormal)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(Color.blackBase)
            }
        }
        .padding(.vertical, 16)
    }

    private func groupView(group: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(group.capitalized)
                    .font(.SFPro.regularLarge)

                Spacer()

                Image(systemName: viewModel.expandedGroups.contains(group) ? "chevron.up" : "chevron.down")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.grayBase)
            }
            .contentShape(Rectangle())
            .onTapGesture {
                viewModel.toggleGroup(group)
            }

            if viewModel.expandedGroups.contains(group) {
                FlexibleLayout(data: viewModel.groupedTags[group] ?? [], spacing: 8) { tag in
                    tagView(tag, isSelected: viewModel.selectedTags.contains(tag))
                }
                .padding(.bottom, 16)
            }
        }
    }

    private func tagView(_ tag: FilterTagItem, isSelected: Bool) -> some View {
        Text(isSelected ? "+ \(tag.title)" : tag.title)
            .font(isSelected ? .SFPro.bodyNormal : .SFPro.lightSmall)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(isSelected ? Color.orangeBase : Color.grayBase.opacity(0.2))
            .foregroundStyle(isSelected ? .white : .blackBase)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .onTapGesture {
                viewModel.toggleTag(tag)
            }
    }
}
