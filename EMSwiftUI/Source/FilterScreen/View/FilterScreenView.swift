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
                Color(.grayBase)
                    .frame(height: 1)
                contentView
            }
            .background(Color.whiteText)
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
                if viewModel.groupedTags.isEmpty {
                    await viewModel.getTags()
                }
            }
        }
    }
    
    @ViewBuilder
    private var contentView: some View {
        switch viewModel.viewState {
        case .idle, .loading:
            LoadingView()
        case .success:
            successView
        case .error(let error):
            ErrorView(error: error) {
                Task {
                    await viewModel.getTags()
                }
            }
        }
    }
    
    // MARK: - Subviews
    private var successView: some View {
        VStack(alignment: .leading, spacing: 16) {
            if !viewModel.selectedTags.isEmpty {
                selectionView
            }
            tagsGroupSection
        }
        .padding(.horizontal, 16)
    }
    
    private var selectionView: some View {
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
            actionButtons
            Divider()
        }
    }
    
    private var tagsGroupSection: some View {
        VStack(alignment: .leading, spacing: 24) {
            ForEach($viewModel.groupedTags, id: \.id) { $group in
                VStack(alignment: .leading, spacing: 8) {
                    HStack(alignment: .center, spacing: 8) {
                        Text(group.group.capitalizingFirstLetter())
                            .font(.SFPro.regularLarge)
                            .foregroundStyle(Color.blackBase)
                        Button {
                            group.isExpanded.toggle()
                            group.isRotating = group.isExpanded ? 270 : 90
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
                            .disabled(viewModel.containsTag(tag))
                        }
                    }
                }
                .animation(nil)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - Button Views
private extension FilterScreenView {
    func tapedTagButton(tag: Tag, _ action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            HStack(spacing: 4) {
                if viewModel.containsTag(tag) {
                    Image(systemName: "plus")
                }
                Text(tag.attributes.name.en ?? "")
                    .font(Font.SFPro.bodyNormal)
            }
            .padding(8)
            .foregroundStyle(viewModel.containsTag(tag) ? .whiteText : .blackBase)
            .background(viewModel.containsTag(tag) ? .orangeBase : .grayBase)
            .cornerRadius(8)
        }
    }
    
    var actionButtons: some View {
        VStack(spacing: 8) {
            Button("Apply", action: viewModel.applyFilters)
                .primaryButtonStyle()
            
            Button("Reset", action: viewModel.resetFilters)
                .secondaryButtonStyle()
        }
    }
}
