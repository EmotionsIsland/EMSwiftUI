//
//  MainView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 17/12/23.
//



import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = MangaListViewModel()
    @State private var isFilterViewPresented = false
    @State private var selectedTab = 0
    @State private var searchText = ""
    
    var body: some View {
        mainView
        if viewModel.isLoading {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white.opacity(0.5))
                .cornerRadius(12)
        }
    }
}

private extension MainView {
    var mainView: some View {
        VStack(spacing: 0) {
            findSearchBar
            Divider()
                .padding(.top, 1)
                .background(Asset.Colors.grayBase.swiftUIColor)
            
            if let error = viewModel.error {
                Text("Error: \(error.localizedDescription)")
                    .foregroundColor(.red)
            } else {
                sectionView
            }
            
            Divider()
                .padding(.top, 1)
                .background(Asset.Colors.grayBase.swiftUIColor)
                .frame(maxWidth: .infinity)
            
            TabBar(selectedTab: $selectedTab)
                .padding(.horizontal, 24)
        }
    }
    
    var findSearchBar: some View {
        HStack(spacing: 0) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(Asset.Colors.grayBase.swiftUIColor)
                .padding(.leading, 7)
            TextField("Search", text: $searchText)
                .padding(.leading, 4)
                .padding(.horizontal, 8)
                .disableAutocorrection(true)
                .autocapitalization(.none)
        }
        .frame(height: 36)
        .background(Color(.systemGray6))
        .cornerRadius(8)
        .foregroundColor(.gray)
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
    
    var sectionView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 16) {
                MangaSectionView(
                    mangaSection: "Popular",
                    mangaList: Array(viewModel.mangaList.prefix(6)),
                    onMoreTapped: {
                        isFilterViewPresented = true
                    }
                )
                MangaSectionView(
                    mangaSection: "Popular",
                    mangaList: Array(viewModel.mangaList.dropFirst(6).prefix(6)),
                    onMoreTapped: {
                        isFilterViewPresented = true
                    }
                )
                MangaSectionView(
                    mangaSection: "Popular",
                    mangaList: Array(viewModel.mangaList.suffix(6)),
                    onMoreTapped: {
                        isFilterViewPresented = true
                    }
                )
            }
            .padding(.top)
        }
    }
}

