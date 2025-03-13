//
//  MainView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 17/12/23.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = MangaListViewModel()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            stateMainView
                .animation(.default, value: viewModel.state)
        }
        .overlay(retryButton, alignment: .center)
        .refreshable { viewModel.getData() }
    }
}

private extension MainView {
    @ViewBuilder
    var stateMainView: some View {
        switch viewModel.state {
        case .loading:
            LoadingView()
        case .loaded where viewModel.mangaData.isEmpty:
            EmptyView()
        case .loaded:
            MangaSectionView(viewModel: viewModel)
        case .error(let description):
            ErrorView(errorMessage: description)
        }
    }
    
    var retryButton: some View {
        Group {
            if case .error = viewModel.state {
                Button(action: viewModel.getData) {
                    Image(systemName: "arrow.clockwise")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                }
            }
        }
    }
}

#Preview {
    MainView()
}
