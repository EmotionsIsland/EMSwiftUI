//
//  MangaSectionView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSectionView<VM: MangaListViewModel>: View {
    private let header: String
    private let columns: [GridItem] = [
        .init(.flexible(), spacing: 25, alignment: .leading),
        .init(.flexible(), spacing: 25, alignment: .leading),
        .init(.flexible(), alignment: .leading)
    ]
    @ObservedObject private var viewModel: VM

    init(viewModel: VM, header: String) {
        self.viewModel = viewModel
        self.header = header
    }

    var body: some View {
        VStack(spacing: 12) {
            MangaSectionTitleView(header: header)

            LazyVGrid(columns: columns) {
                ForEach(viewModel.mangaData, id: \.id) { model in
                    MangaSingleGridView(
                        model: model,
                        urlForImage: viewModel.getCoverURL(manga: model, sizeFormat: .size256)
                    )
                }
            }
        }
        .padding(.top, 24)
    }
}
