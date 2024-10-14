//
//  MainView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 17/12/23.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject private var viewModel = MangaListViewModel(mangaListService: MangaListService(network: Network()))
    
    var body: some View {
        VStack(spacing: 8) {
            
            switch viewModel.state {
            case .successfull:
                mockSearchBar
                Divider()
                loadedView
            case .failed(let error):
                errorView(error)
            case .notAvailable:
                ProgressView()
            }
        }
        .onAppear {
            viewModel.getData()
        }
        
    }
}

private extension MainView {
    
    var loadedView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 24) {
                MangaSectionView(mangas: viewModel.mangaData.reversed())
                MangaSectionView(mangas: viewModel.mangaData)
            }
        }
        .padding()
        .ignoresSafeArea()
    }
    
    var mockSearchBar: some View {
        Rectangle()
            .frame(maxWidth: .infinity, maxHeight: 40)
            .foregroundStyle(.grayBase)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.horizontal, 16)
    }
    
    func errorView(_ error: Error) -> some View {
        Text(error.localizedDescription)
            .multilineTextAlignment(.center)
            .frame(alignment: .center)
            .font(FontFamily.SFProText.medium.swiftUIFont(size: 22))
    }
    
}
