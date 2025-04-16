//
//  MangaListScreen.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 17/12/23.
//

import SwiftUI

struct MangaListScreen<VM: MangaListViewModel>: View {
    @StateObject private var viewModel: VM

    init(viewModel: VM) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            switch viewModel.dataState {
            case .successfull:
                VStack(spacing: 0) {
                    searchBar
                        .padding(.bottom, 8)
                        .padding(.horizontal, 16)
                    Divider()
                    ForEach(viewModel.headers, id: \.self) { header in
                        MangaSectionView(viewModel: viewModel, header: header)
                    }
                    .padding(.horizontal, 16)
                }
            case .failed(let error):
                Text(error.localizedDescription)
            case .notAvailable:
                ProgressView()
            }
        }
    }
}

private extension MangaListScreen {
    var searchBar: some View {
        HStack(spacing: 4) {
            Image(.search)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 24, height: 24)
                .foregroundStyle(.grayBase)
                .padding(.vertical, 6)
                .padding(.leading, 4)

            TextField("Search", text: $viewModel.searchText)
                .frame(maxWidth: .infinity)
        }
        .frame(height: 36)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.whiteText)
        )
    }
}
