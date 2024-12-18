//
//  MainView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 17/12/23.
//

import SwiftUI

struct MainView: View {
    
    @StateObject private var viewModel = MangaListViewModel()
    @State private var searchText: String = ""
    
    var body: some View {
        VStack(spacing: 8) {
            switch viewModel.dataState {
            case .successfull:
                searchBarView
                navigationDivider
                mangaContentView
            case .failed(let error):
                Text(error.localizedDescription)
            case .notAvailable:
                ProgressView()
            }
        }
    }
}

extension MainView {
    
    private var searchBarView: some View {
        HStack(spacing: 7) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.grayBase)
            TextField("",
                      text: $searchText,
                      prompt: Text("Search")
                .foregroundColor(.grayBase))
        }
        .hSpacing(.leading)
        .padding(8)
        .background(.whiteText, in: RoundedRectangle(cornerRadius: 8))
        .font(.custom(FontFamily.SFProText.thin, size: 14))
        .padding(.horizontal, 16)
    }
    
    private var navigationDivider: some View {
        Rectangle()
            .hSpacing()
            .frame(height: 1)
            .foregroundStyle(.grayBase)
    }
    
    private var mangaContentView: some View {
        VStack(spacing: 24) {
            ScrollView(.vertical, showsIndicators: false) {
                MangaSectionTitleView(title: "Popular")
                MangaSectionView(mangaData: viewModel.mangaList)
            }
        }
        .padding(.horizontal, 16)
    }
    
}
