//
//  FilterScreen.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct FilterScreen<VM: FilterScreenViewModel>: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: VM
    
    init(viewModel: VM) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack(spacing: 0) {
            header
            contentArea
        }
        .onAppear {
            viewModel.load()
        }
    }
    
    private var header: some View {
        VStack(spacing: 0) {
            ZStack {
                Text("Filters")
                    .font(.SFPro.headline2)
                HStack {
                    Spacer()
                    Button { dismiss() } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 15, weight: .semibold))
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            Divider().background(Color.grayBase)
        }
        .foregroundStyle(.blackBase)
        .background(Color.white)
    }
    
    @ViewBuilder
    private var contentArea: some View {
        switch viewModel.loadingState {
        case .loading:
            ProgressView()
        case .error(let message):
            errorView(message)
        case .loaded(let groupedTags):
            loadedContent(groupedTags: groupedTags)
        }
    }
    
    private func loadedContent(groupedTags: [String: [FilterChipItem]]) -> some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    SelectedTagsSection(viewModel: viewModel) {
                        viewModel.applyAndDismiss(using: dismiss)
                    }
                    Divider().padding(.vertical, 12)
                    ForEach(groupedTags.keys.sorted(), id: \.self) { group in
                        if let tags = groupedTags[group] {
                            ExpandableTagGroup(viewModel: viewModel,
                                               groupTitle: group,
                                               tags: tags)
                        }
                    }
                }
                .padding(.horizontal, 16)
                .frame(width: geometry.size.width)
            }
        }
    }
    
    private func errorView(_ message: String) -> some View {
        VStack(spacing: 12) {
            Text(message).font(.SFPro.bodyNormal)
            Button("Retry") { viewModel.retry() }
                .font(.SFPro.bodyNormal)
                .padding(.horizontal, 20)
                .padding(.vertical, 8)
                .background(Color.orangeBase)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        .padding()
    }
}
