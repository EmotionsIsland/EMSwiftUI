//
//  FilterScreen.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct FilterScreen<VM: FilterTagsViewModel>: View {
    @StateObject private var viewModel: VM
    private let horizontalPadding: CGFloat = 16
    
    init(viewModel: VM) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        GeometryReader { geometry in
            contentView(contentWidth: geometry.size.width - horizontalPadding * 2)
        }
        .task {
            await viewModel.load()
        }
    }
}

private extension FilterScreen {
    private func contentView(contentWidth: CGFloat) -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                titleView
                selectedTagsView(contentWidth: contentWidth)
                sectionsView(contentWidth: contentWidth)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    private var titleView: some View {
        Text("Selection")
            .font(.system(size: 20, weight: .bold))
            .foregroundColor(.black)
            .padding(.top, 16)
            .padding(.horizontal, horizontalPadding)
    }

    @ViewBuilder
    private func selectedTagsView(contentWidth: CGFloat) -> some View {
        if !viewModel.selectedTags.isEmpty {
            VStack(alignment: .leading, spacing: 8) {
                FlexibleTagsView(
                    tags: viewModel.selectedTags,
                    maxWidth: contentWidth,
                    isSelected: { _ in true },
                    onTap: { tag in viewModel.toggleTag(tag) }
                )
                actionsView
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, horizontalPadding)
        }
    }

    private func sectionsView(contentWidth: CGFloat) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(FilterSectionType.allCases) { section in
                filterSectionView(section, contentWidth: contentWidth)
            }
        }
    }

    private func filterSectionView(_ section: FilterSectionType, contentWidth: CGFloat) -> some View {
        FilterSectionView(
            title: section.rawValue,
            isExpanded: viewModel.expandedSections.contains(section),
            onHeaderTap: { viewModel.toggleSection(section) },
            content: {
                AnyView(
                    FlexibleTagsView(
                        tags: viewModel.sections[section] ?? [],
                        maxWidth: contentWidth,
                        isSelected: { viewModel.isSelected($0) },
                        onTap: { tag in viewModel.toggleTag(tag) }
                    )
                )
            }
        )
        .padding(.horizontal, horizontalPadding)
    }

    private var actionsView: some View {
        VStack(spacing: 12) {
            applyButton
            resetButton
        }
        .padding(.top, 4)
    }

    private var applyButton: some View {
        Button {
            viewModel.apply()
        } label: {
            Text("Apply")
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(Color("orangeBase"))
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        }
        .buttonStyle(.plain)
    }

    private var resetButton: some View {
        Button {
            viewModel.reset()
        } label: {
            Text("Reset")
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(.black)
        }
        .buttonStyle(.plain)
    }
}
