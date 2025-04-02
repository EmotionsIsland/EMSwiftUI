//
//  MangaGridView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaGridView<ViewModel: MangaListViewModel>: View {
    @ObservedObject var viewModel: ViewModel

    private let columns: [GridItem] = [
        GridItem(.fixed(100), spacing: 25),
        GridItem(.fixed(100), spacing: 25),
        GridItem(.fixed(100), spacing: 25)
    ]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 25, pinnedViews: .sectionHeaders) {
            ForEach(viewModel.items) {
                MangaGridCellView($0, viewModel: viewModel)
            }
        }
    }
}

struct MangaGridCellView<ViewModel: MangaListViewModel>: View {
    @ObservedObject var viewModel: ViewModel

    @State private var cover: UIImage?

    let item: MangaListItem

    init(_ item: MangaListItem, viewModel: ViewModel) {
        self.item = item
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(spacing: 4) {
            Group {
                if let cover {
                    Image(uiImage: cover)
                        .resizable()
                } else {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .foregroundStyle(.secondary)
                }
            }
            .aspectRatio(100 / 144, contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 4))

            VStack(alignment: .leading, spacing: 2) {
                Text(item.title)
                    .lineLimit(1)
                    .font(.SFPro.semiboldNormal)
                    .foregroundStyle(.blackBase)

                RatingView(Double.random(in: 1...5))

                Text(item.genres.joined(separator: ", "))
                    .lineLimit(1)
                    .font(.SFPro.lightSmall)
                    .foregroundStyle(.grayBase)
            }
        }
        .task {
            cover = await viewModel.fetchCover(for: item)
        }
    }
}
