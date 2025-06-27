//
//  MangaListScreen.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 17/12/23.
//

import SwiftUI

struct MangaListScreen<VM: MangaListViewModel>: View {
    @StateObject private var viewModel: VM
    @State private var userInput: String = ""
    
    init(viewModel: VM) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            SearchBar(searchText: $userInput)
            
            Divider()
                .padding(.vertical, 10)
            
            ScrollView(.vertical, showsIndicators: false) {
                MangaSectionView(viewModel: viewModel, sectionName: "Popular", mangas: viewModel.mangaModel?.data ?? [])
                
                MangaSectionView(viewModel: viewModel, sectionName: "Recently Added", mangas: viewModel.sortByRecent())
                
                MangaSectionView(viewModel: viewModel, sectionName: "Last updates", mangas: viewModel.sortByLastUpdated())
                
                MangaSectionView(viewModel: viewModel, sectionName: "Seasonal", mangas: viewModel.sortBySeason(season: .summer))
            }
        }
    }
}

#Preview {
    MangaListScreenBuilder.build()
}
