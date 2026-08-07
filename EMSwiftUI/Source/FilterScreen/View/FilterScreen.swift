//
//  FilterScreen.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct FilterScreen<VM: FilterViewModel>: View {
    @StateObject private var viewModel: VM

    init(viewModel: VM) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack(spacing: 32) {
            header
            ScrollView(.vertical, showsIndicators: false) {
                switch viewModel.viewState {
                case .loading, .initial:
                    ProgressView("Loading")
                case .loaded:
                    SelectedTagsView(viewModel: viewModel)
                    Divider()
                        .padding(.bottom, 8)
                    VStack {
                        ForEach(viewModel.groupedTags, id: \.key) { section in
                            ExpandableView(title: viewModel.displayName(for: section.key),
                                           tags: section.tags,
                                           viewModel: viewModel)
                                .padding(.bottom, 20)
                        }
                    }
                case .error(let error):
                    VStack {
                        Text("Ошибка: \(error.localizedDescription)")
                        Button("Повторить") {
                            Task { await viewModel.retry() }
                        }
                    }
                }
            }.padding(.horizontal, 16)
        }
        .task {
            await viewModel.loadData()
        }
    }

    private var header: some View {
        ZStack {
            Text("Filters")
                .font(.SFPro.headline2)
            HStack {
                Spacer()
                Button {  } label: {
                    Image("close")
                }
            }
        }
        .foregroundStyle(.blackBase)
        .padding(.horizontal, 16)
        .bottomSeparator()
    }
}
