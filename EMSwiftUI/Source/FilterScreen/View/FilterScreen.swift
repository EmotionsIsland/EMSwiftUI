//
//  FilterScreen.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct FilterScreen<VM: FilterScreenViewModel>: View {
    @StateObject private var viewModel: VM
    
    init(viewModel: VM) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        content
            .task {
                await reload()
            }
            .refreshable {
                await reload()
            }
    }
}

extension FilterScreen {
    @ViewBuilder
    private var content: some View {
        switch viewModel.loadState {
        case .loading, .idle:
            ProgressView()
        case .failure:
            failureContent
        case .success:
            successContent
        }
    }
    
    private var failureContent: some View {
        LoadingFailureView(errorMessage: "Something went wrong while loading tags. Please try again later.") {
            await reload()
        }
    }
    
    private var successContent: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem()], alignment: .leading) {
                chosenTagsSection
                Divider()
                tagsSection
            }
            .padding()
        }
    }
    
    private var chosenTagsSection: some View {
        Section {
            FilterSectionView(
                tags: viewModel.chosenTags,
                chosenTagsIDs: nil) { tag in
                    viewModel.toggleTag(tag)
                }
            FilterMainSectionButtonsView(isActive: !viewModel.chosenTags.isEmpty) {
                viewModel.resetTags()
            }
            .padding(.top)
        } header: {
            Text("Selection")
                .font(.SFPro.headline2)
        }
    }
    
    private var tagsSection: some View {
        ForEach(viewModel.tagGroups) { tagGroup in
            Section {
                if tagGroup.isExpanded {
                    FilterSectionView(
                        tags: tagGroup.tags,
                        chosenTagsIDs: Set(viewModel.chosenTags.map(\.id))) { tag in
                            viewModel.toggleTag(tag)
                        }
                }
            } header: {
                FilterSectionHeader(sectionTitle: tagGroup.groupTitle, isExpanded: tagGroup.isExpanded) {
                    viewModel.toggleGroup(tagGroup)
                }
            }
        }
    }
    
    private func reload() async {
        try? await viewModel.onAppear()
    }
}
