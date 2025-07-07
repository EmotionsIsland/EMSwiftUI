//
//  FilterScreen.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct FilterScreen<VM: FilterScreenViewModel>: View {
    @StateObject private var viewModel: VM
    @State private var loadState: LoadState = .idle
    
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
        switch loadState {
        case .loading, .idle:
            ProgressView()
        case .failure:
            VStack(spacing: 12) {
                Text("Something went wrong while loading tags. Please try again later.")
                    .font(.SFPro.semiboldNormal)
                    .multilineTextAlignment(.center)
                    .padding()
                Button("Try again") {
                    Task {
                        await reload()
                    }
                }
                .foregroundStyle(.whiteText)
                .padding(12)
                .frame(maxWidth: .infinity)
                .background(.orangeBase)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding(.horizontal)
            }
        case .success:
            ScrollView {
                LazyVGrid(columns: [GridItem()], alignment: .leading) {
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
                    Divider()
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
                .padding()
            }
        }
    }
    
    private func reload() async {
        loadState = .loading
        do {
            try await viewModel.onAppear()
            loadState = .success
        } catch {
            loadState = .failure(error)
        }
    }
}
