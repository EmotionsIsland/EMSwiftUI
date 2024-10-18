//
//  MainView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 17/12/23.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var viewModel = MangaListViewModel()
    
    @State private var isFilterShown = false
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
        
            VStack {
                searchField
                    .padding()
                
                Divider()
                
                ScrollView(.vertical, showsIndicators: false) {
                    MangaSectionView(
                        sectionTitle: "Popular",
                        mangaListViewModel: viewModel
                    )
                    MangaSectionView(
                        sectionTitle: "Recently Added",
                        mangaListViewModel: viewModel
                    )
                    MangaSectionView(
                        sectionTitle: "Last updates",
                        mangaListViewModel: viewModel
                    )
                    
                    MangaSectionView(
                        sectionTitle: "Seasonal",
                        mangaListViewModel: viewModel
                    )
                }
                .padding()
            }
        }
    }
}

#Preview {
    MainView(viewModel: MangaListViewModel())
}

private extension MainView {
    var searchField: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.gray)
                .padding(.leading, 4)
            
            TextField("Search", text: $searchText)
                .frame(height: 36)
                .padding(.leading, 4)
        }
        .background(.grayBase)
        .cornerRadius(8)
        .frame(maxWidth: .infinity)
    }
}
