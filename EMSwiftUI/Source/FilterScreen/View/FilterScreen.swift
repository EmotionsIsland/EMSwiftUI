//
//  FilterScreen.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct FilterScreen<VM: FilterTagsViewModel>: View {
    @StateObject private var viewModel: VM
    
    init(viewModel: VM) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        GeometryReader { geometry in
            contentView(contentWidth: geometry.size.width - 32)
        }
        .task {
            await viewModel.load()
        }
    }

    private func contentView(contentWidth: CGFloat) -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                Text("Selection")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.top, 16)
                    .padding(.horizontal)

                if !viewModel.selectedTags.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        FlexibleTagsView(
                            tags: viewModel.selectedTags,
                            maxWidth: contentWidth,
                            isSelected: { _ in true },
                            onTap: { tag in viewModel.toggleTag(tag) }
                        )
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                }

                VStack(alignment: .leading, spacing: 8) {
                    ForEach(FilterSectionType.allCases) { section in
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
                        .padding(.horizontal)
                    }
                }

                VStack(spacing: 12) {
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
                    .padding(.horizontal)

                    Button {
                        viewModel.reset()
                    } label: {
                        Text("Reset")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(.black)
                    }
                    .buttonStyle(.plain)
                }
                .padding(.bottom, 24)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
