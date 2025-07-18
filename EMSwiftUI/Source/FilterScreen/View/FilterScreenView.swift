//
//  FilterScreen.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI
import Factory

struct FilterScreenView<ViewModel: FilterScreenViewModel>: View {
    @StateObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Section {
                TagsFlowLayoutView(tags: viewModel.selectedTags,
                                   selectedTagsIDs: Set(viewModel.selectedTags.map { $0.id })) { tag in
                    viewModel.toggleTag(tag)
                }
            } header: {
                HStack {
                    Text("Selection")
                        .font(.custom("SFProText-Bold", size: 20))
                        .foregroundStyle(
                            Color.blackBase
                        )
                            
                    Spacer()
                }
            }
            .animation(.spring(response: 0.4, dampingFraction: 0.7), value: viewModel.selectedTags)
            
            VStack(spacing: 8) {
                Button {
                    // ...
                } label: {
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: 358, height: 44)
                        .foregroundStyle(
                            Color.orangeBase
                        )
                        .overlay {
                            Text("Apply")
                                .font(.custom("SFProDisplay-Medium", size: 16))
                                .foregroundStyle(Color.whiteText)
                        }
                }
                        
                Button {
                    viewModel.emptySelectedTags()
                } label: {
                    Text("Reset")
                        .font(.custom("SFProDisplay-Medium", size: 16))
                        .foregroundStyle(
                            Color.blackBase
                        )
                }
            }
                    
            Divider()
                .foregroundStyle(
                    Color.grayBase
                )
                .padding(.horizontal)
                
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    ForEach(viewModel.tagGroups) { group in
                        Section {
                            if group.isUnfolded {
                                TagsFlowLayoutView(tags: group.tags,
                                                   selectedTagsIDs: Set(viewModel.selectedTags.map { $0.id })) { tag in
                                    viewModel.toggleTag(tag)
                                }
                            }
                        } header: {
                            HeaderView(
                                isUnfolded: group.isUnfolded,
                                groupTitle: group.title.capitalized
                            ) {
                                viewModel.toggleGroup(group)
                            }
                        }
                    }
                }
            }
                
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .task {
            await viewModel.onAppear()
        }
        .padding()
    }
}
