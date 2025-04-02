//
//  MangaListScreen.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 17/12/23.
//

import SwiftUI

struct MangaListScreen<ViewModel: MangaListViewModel>: View {
    @StateObject private var viewModel: ViewModel

    @State private var isFetching: Bool = true

    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack {
            if isFetching {
                ProgressView()
                    .progressViewStyle(.circular)
                    .foregroundStyle(.secondary)
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(MangaSection.allCases, id: \.self) {
                        Section {
                            MangaGridView(viewModel: viewModel)
                        } header: {
                            MangaSectionHeaderView()
                        }
                        .environment(\.mangaListSection, $0)
                    }
                }
                .padding(.horizontal)
            }
        }
        .task {
            await viewModel.fetchItems()

            isFetching = false
        }
    }
}

#Preview {
    MangaListScreenBuilder.build()
}
