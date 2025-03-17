//
//  MainView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 17/12/23.
//

import SwiftUI

struct MainView: View {
    @State private var searchText: String = ""
    @ObservedObject var viewModel: MangaListViewModel
    private let sections = ["Popular", "Recently Added", "Last Updated", "Seasonal"]
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack {
                    Divider()
                    ForEach(sections, id: \.self) { section in
                        MangaSectionView(viewModel: viewModel, title: section, mangaList: viewModel.mangaData)
                    }
                }
            }
            .searchable(text: $searchText)
        }
    }
}
