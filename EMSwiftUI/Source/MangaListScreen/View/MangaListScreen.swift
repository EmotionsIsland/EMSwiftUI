//
//  MangaListScreen.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 17/12/23.
//

import SwiftUI

struct MangaListScreen<VM: MangaListViewModel>: View {
    @StateObject private var viewModel: VM
    @State private var searchText: String = ""
    
    init(viewModel: VM) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    private var filtered: [MangaUIModel] {
        let textToSearch = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !textToSearch.isEmpty else { return MangaMocks.popular }
        return MangaMocks.popular.filter { $0.title.localizedCaseInsensitiveContains(textToSearch) }
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 12) {
                SearchBar(searchText: $searchText)
                
                
                Rectangle()
                    .fill(Color.black.opacity(0.1))
                    .frame(height: 1)

                MangaSectionView(title: "Popular", items: filtered) {
                    print("tap more 1")
                }

                MangaSectionView(title: "Recently Added", items: filtered) {
                    print("tap more 2")
                }
                
                MangaSectionView(title: "Last updates", items: filtered) {
                    print("tap more 3")
                }
            }
        }
    }
}
