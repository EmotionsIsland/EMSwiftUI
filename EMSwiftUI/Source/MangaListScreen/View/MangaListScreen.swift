//
//  MangaListScreen.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 17/12/23.
//

import SwiftUI

struct MangaListScreen<ViewModel: MangaListViewModel>: View {
    @StateObject private var viewModel: ViewModel

    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack {
            if viewModel.isFetching {
                ProgressView()
                    .progressViewStyle(.circular)
                    .foregroundStyle(.secondary)
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 8) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.grayBase)
                            .frame(maxWidth: .infinity)
                            .frame(height: 38)
                            .padding(.horizontal)

                        Divider()

                        ForEach(MangaSection.allCases, id: \.self) {
                            Section {
                                MangaGridView(items: viewModel.items)
                            } header: {
                                MangaSectionHeaderView()
                            }
                            .environment(\.mangaListSection, $0)
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
    }
}

#Preview {
    MangaListScreenBuilder.build()
}
