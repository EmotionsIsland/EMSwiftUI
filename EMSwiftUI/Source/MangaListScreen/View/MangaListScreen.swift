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
        VStack(spacing: 24) {
            SearchBarView()

            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 24) {
                    ForEach(viewModel.sections, id: \.self) { sectionTitle in
                        MangaSectionView(title: sectionTitle, mangaList: viewModel.mangaList)
                    }
                }
            }
        }
    }
}
