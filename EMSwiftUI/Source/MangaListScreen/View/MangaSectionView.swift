//
//  MangaSectionView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSectionView<VM: MangaListViewModel>: View {
    private let columns: [GridItem] = .init(
        repeating: .init(.flexible(), spacing: 25, alignment: .leading),
        count: 3
    )
    let header: String
    @ObservedObject var viewModel: VM

    var body: some View {
        VStack(spacing: 12) {
            MangaSectionTitleView(header: header)

            LazyVGrid(columns: columns) {
                ForEach(viewModel.filteredData, id: \.id) { model in
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
