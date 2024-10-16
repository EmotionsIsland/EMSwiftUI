//
//  MainView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 17/12/23.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = MangaListViewModel()
    @State private var searchText = ""
    
    var body: some View {
        
        NavigationView {
            VStack {
                searchBar
                    .padding(.horizontal)
                
                Divider()
                
                ScrollView(showsIndicators: false) {
                    MangaView(title: "Popular", items: viewModel.mangaList)
                        .environmentObject(viewModel)
                    MangaView(title: "Recently Added", items: viewModel.mangaList)
                        .environmentObject(viewModel)
                    MangaView(title: "Last updates", items: viewModel.mangaList)
                        .environmentObject(viewModel)
                }
            }
            .alert(isPresented: $viewModel.hasError) {
                Alert(title: Text("Error"), message: Text("Failed to load data"))
            }
        }
    }
}

private extension MainView {
    var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .padding(.leading, 4)
                .foregroundColor(.gray)
            TextField("Search", text: $searchText)
                .frame(height: 36)
                .padding(.leading, 8)
        }
        .background(Color.gray.opacity(0.2))
        .cornerRadius(8)
        .frame(maxWidth: .infinity)
    }
}


