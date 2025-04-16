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
                    RoundedRectangle(cornerRadius: 8, style: .circular)
                        .frame(height: 36)
                        .foregroundStyle(.gray)
                        .padding(.bottom, 8)
                        .padding(.horizontal, 16)
                    Divider()
                    ForEach(0..<2) { _ in
                        MangaSectionView(viewModel: viewModel, header: "Popular")
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
