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
                VStack(spacing: 24) {
                    SearchView()
                    
                    if !viewModel.mangas.isEmpty {
                        MangaSectionView(
                            viewModel: viewModel
                        )
                    }
                }
            }
        }
    }
}

