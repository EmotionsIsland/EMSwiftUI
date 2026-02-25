//
//  FilterScreen.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI
import Factory

struct FilterScreen: View {
    @StateObject private var viewModel: FilterScreenViewModel

    init(service: FilterTagsServiceProtocol) {
        _viewModel = StateObject(wrappedValue: FilterScreenViewModel(service: service))
    }

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                SelectionView(selected: viewModel.selectedTags) { tag in
                    viewModel.toggleTag(tag)
                }

                PrimaryButton(
                    title: "Apply",
                    bgColor: .orangeBase,
                    textColor: .whiteText
                ) {
                    print("Apply:", viewModel.selectedIDs)
                }

                PrimaryButton(
                    title: "Reset",
                    bgColor: .white,
                    textColor: .blackBase
                ) {
                    viewModel.reset()
                }

                Divider().padding(.vertical, 8)

                ForEach(viewModel.sections) { section in
                    FilterSectionView(
                        title: section.title,
                        isExpanded: section.isExpanded,
                        onToggle: { viewModel.toggleSection(section.id) },
                        content: {
                                TagChipsGrid(
                                    tags: section.tags,
                                    isSelected: { viewModel.isSelected($0) },
                                    onTap: { viewModel.toggleTag($0) }
                                )
                        }
                    )
                }
            }
            .padding(16)
        }
        .task { await viewModel.load() }
    }
}
