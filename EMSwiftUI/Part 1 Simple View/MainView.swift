//
//  MainView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 17/12/23.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MangaListViewModel(mangaService: MangaListService(network: Network()))
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                    if !viewModel.mangas.isEmpty {
                        MangaSectionView(
                            viewModel: viewModel
                        )
                    }
            }
            .padding(.top, 20)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    SearchView()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

