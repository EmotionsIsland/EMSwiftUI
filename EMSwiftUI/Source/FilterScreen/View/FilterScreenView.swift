//
//  FilterScreen.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct FilterScreenView<VM: FilterViewModel>: View {
    @StateObject private var viewModel: VM
    
    init(viewModel: VM) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    if !viewModel.selectedTags.isEmpty {
                        selectionView
                    }
                    Divider()
                    tagsGroup
                }
                .padding(.horizontal, 16)
            }
            .navigationTitle("Filters")
            .navigationBarBackButtonHidden()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Image(.close)
                        .resizedToFill(width: 30, height: 30)
                }
            }
            .task {
                await viewModel.getTags()
            }
        }
    }
    
    @ViewBuilder
    var tagsGroup: some View {
        VStack(alignment: .leading, spacing: 24) {
            ForEach($viewModel.groupedTags, id: \.id) { $group in
                VStack(alignment: .leading, spacing: 8) {
                    HStack(alignment: .center, spacing: 8) {
                        Text(group.group.capitalizingFirstLetter())
                            .font(.SFPro.regularLarge)
                            .foregroundStyle(Color.blackBase)
                        Button {
                            withAnimation(.spring(duration: 0.3, bounce: 0.1)) {
                                group.isExpanded.toggle()
                                group.isRotating = group.isExpanded ? 270 : 90
                            }
                        } label: {
                            Image(.moreIcon)
                                .rotationEffect(.degrees(group.isRotating))
                                .tint(.blackBase)
                                .animation(.easeInOut, value: group.isRotating)
                        }
                    }
                    if group.isExpanded {
                        FlexibleView(
                            data: group.tags,
                            spacing: 8,
                            alignment: HorizontalAlignment.leading
                        ) { tag in
                            tapedTagButton(tag: tag) {
                                    viewModel.selectedTags.append(tag)
                            }
                            .disabled(viewModel.selectedTags.contains(tag))
                        }
                    }
                }
                .animation(nil)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func tapedTagButton(tag: Tag, _ action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            HStack(spacing: 4) {
                Image(systemName: "plus")
                Text(tag.attributes.name.en ?? "")
                    .font(Font.SFPro.bodyNormal)
            }
            .padding(8)
            .foregroundStyle(viewModel.selectedTags.contains(tag) ? .whiteText : .blackBase)
            .background(viewModel.selectedTags.contains(tag) ? .orangeBase : .grayBase)
            .cornerRadius(8)
        }
    }
    
    var buttonsSection: some View {
        VStack(spacing: 8) {
            Button {
                //
            } label: {
                Text("Apply")
                    .font(Font.SFPro.bodyNormal)
                    .foregroundStyle(.whiteText)
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .background(.orangeBase)
            .cornerRadius(8)
            
            Button {
                viewModel.selectedTags.removeAll()
            } label: {
                Text("Reset")
            }
            .font(Font.SFPro.bodyNormal)
            .foregroundStyle(.blackBase)
        }
    }
    
    var selectionView: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Selection")
                .font(.SFPro.headline3)
                .foregroundStyle(Color.blackBase)
            FlexibleView(
                data: viewModel.selectedTags,
                spacing: 8,
                alignment: HorizontalAlignment.leading
            ) { tag in
                tapedTagButton(tag: tag) {
                    viewModel.selectedTags.removeAll { $0.id == tag.id }
                }
            }
            buttonsSection
        }
    }
}
