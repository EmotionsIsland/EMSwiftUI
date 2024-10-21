//
//  MainView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 17/12/23.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var viewModel = MangaListViewModel(mangaListService: MangaListService(network: Network()))
    
    @State private var isFilterShown = false
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
        
            VStack {
                searchField
                    .padding()
                
                Divider()
                
                switch viewModel.state {
                case .successfull, .notAvailable:
                    ScrollView(.vertical, showsIndicators: false) {
                        MangaSectionView(
                            sectionTitle: "Popular",
                            viewModel: viewModel
                        )
                        MangaSectionView(
                            sectionTitle: "Recently Added",
                            viewModel: viewModel
                        )
                        MangaSectionView(
                            sectionTitle: "Last updates",
                            viewModel: viewModel
                        )
                        
                        MangaSectionView(
                            sectionTitle: "Seasonal",
                            viewModel: viewModel
                        )
                    }
                    .padding()
                case .failed(let error):
                    Text("Error: \(error.localizedDescription)")
                        .frame(alignment: .center)
                }
            }
        }
        .fullScreenCover(isPresented: $isFilterShown) {
            FilterView()
        }
    }
}

#Preview {
    MainView(viewModel: MangaListViewModel(mangaListService: MangaListService(network: Network())))
}

private extension MainView {
    var searchField: some View {
        HStack {
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
            
            Button("Filter") {
                isFilterShown.toggle()
            }
            .foregroundStyle(.blackBase)
        }
        .frame(maxWidth: .infinity)
    }
}
