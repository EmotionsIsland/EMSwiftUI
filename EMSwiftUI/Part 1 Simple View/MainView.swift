//
//  MainView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 17/12/23.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: MangaListViewModel
    @StateObject var filterViewModel = FilterViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    searchBarView
                    
                    NavigationLink {
                        FilterView()
                            .environmentObject(filterViewModel)
                            .navigationTitle("Filters")
                    } label: {
                        filterButton
                    }
                }
                
                Divider()
                
                VStack {
                    mangaSections
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}

private extension MainView {
    var searchBarView: some View {
        RoundedRectangle(cornerRadius: 4)
            .foregroundStyle(.grayBase)
            .frame(height: 36)
            .padding(.horizontal)
    }
    
    var mangaSections: some View {
        contentView
    }
    
    @ViewBuilder
    var contentView: some View {
        switch viewModel.state {
        case .successfull:
            if let mangaModel = viewModel.mangaModel?.data {
                if mangaModel.isEmpty{
                    emptyStateView
                } else {
                    ScrollView(.vertical, showsIndicators: false) {
                        ForEach(0..<3) { _ in
                            MangaSectionView(viewModel: viewModel)
                        }
                    }
                }
            }
        case .failed(let error):
            showError(error)
        case .notAvailable:
            ProgressView("Loading")
                .frame(alignment: .center)
        }
    }
}

private extension MainView {
    var emptyStateView: some View {
        Text("No Manga Available")
            .font(.headline)
            .foregroundColor(.grayBase)
            .padding()
    }
    
    var filterButton: some View {
        Text("Filter")
            .foregroundColor(.blackBase)
            .padding(.trailing, 16)
    }
    
    func showError(_ error: Error) -> some View {
        Text(error.localizedDescription)
            .foregroundColor(.red)
            .multilineTextAlignment(.center)
            .padding()
    }
    
}
