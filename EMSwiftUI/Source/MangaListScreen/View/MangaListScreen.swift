//
//  MangaListScreen.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 17/12/23.
//

import SwiftUI

struct MangaListScreen<VM: MangaListViewModel>: View {
    private let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 29),
        GridItem(.flexible(), spacing: 29),
        GridItem(.flexible(), spacing: 29)
    ]
    
    @StateObject private var viewModel: VM
    @State private var searchText = ""
    
    init(viewModel: VM) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack {
                MangaTextFieldView()
                Divider()
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(viewModel.sections) { section in
                        Section {
                            ForEach(section.items) { manga in
                                MangaSingleGridView(manga: manga, viewModel: viewModel)
                            }
                        } header: {
                            MangaSectionHeaderView(title: section.title)
                        }
                    }
                }
                .padding()
            }
        }
        .task {
            await viewModel.getData()
        }
    }
}
