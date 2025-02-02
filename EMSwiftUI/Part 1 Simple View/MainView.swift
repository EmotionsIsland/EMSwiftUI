//
//  MainView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 17/12/23.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = MangaListViewModel(service: MangaListService(network: Network()))
    @State private var isSearching = false
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: FilterView(), isActive: $isSearching) {
                    EmptyView()
                }
                .hidden()

                SearchBar(isSearching: $isSearching)

                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        ForEach(viewModel.mangaList, id: \.id) { manga in
                            let sectionTitle = manga.attributes.tags.first?.attributes.name.en ?? "Unknown"
                            MangaSectionView(
                                title: sectionTitle,
                                manga: viewModel.mangaList,
                                viewModel: viewModel
                            )
                        }
                        .padding()
                    }
                }
                .ignoresSafeArea(edges: .bottom)
            }
            .navigationBarHidden(true)
        }
    }
}

struct SearchBar: View {
    @Binding var isSearching: Bool
    
    var body: some View {
        HStack {
            Text("Seach")
                .foregroundColor(.gray)
                .padding(.leading, 10)
            
            Spacer()
        }
        .frame(height: 40)
        .background(Color(.systemGray6))
        .cornerRadius(8)
        .padding()
        .onTapGesture {
            isSearching = true
        }
    }
}
