//
//  MainView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 17/12/23.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MangaListViewModel()
    @State var searchText = ""
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack() {
                    MangaView(title: "Popular", items: viewModel.mangaList)
                        .environmentObject(viewModel)
                    MangaView(title: "Recently Added", items: viewModel.mangaList)
                        .environmentObject(viewModel)
                    MangaView(title: "Last updates", items: viewModel.mangaList)
                        .environmentObject(viewModel)
                }
            }
            .padding(.horizontal, 16)
            .toolbar { searchBar }
            .onAppear {
                viewModel.getData()
            }
            .alert(isPresented: $viewModel.hasError) {
                Alert(title: Text("Error"), message: Text("Failed to load data"))
            }
        }
    }
    
    var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .padding(.leading, 4)
                .foregroundStyle(.grayBase)
            TextField("Search", text: $searchText)
                .frame(height: 36)
                .padding(.leading, 8)
        }
        .background(Color.gray.opacity(0.2))
        .cornerRadius(8)
        .frame(width: 358)
    }
}

