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
                    VStack(spacing: 24) {
                        if !viewModel.mangas.isEmpty {
                            MangaSectionView(
                                mangaData: viewModel.mangas,
                                viewModel: viewModel
                            )
                        }
                    }
                }
            }
        }
    }
}

struct SearchView: View {
    @State var text = ""
    
    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 7) {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .frame(width: 18, height: 18)
                    .foregroundStyle(.grayBase)
                    .padding(.leading, 7)
                
                TextField("Search", text: $text)
                    .frame(height: 36)
                    .cornerRadius(8)
                    .font(FontFamily.SFPro.light.swiftUIFont(size: 14))
                    .foregroundStyle(.grayBase)
            }
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(.grayBase.opacity(0.3))
            )
            .padding(.horizontal, 16)
            
            Divider()
                .background(.gray)
        }
    }
}
