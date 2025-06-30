//
//  MangaListScreen.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 17/12/23.
//

import SwiftUI

struct MangaListScreen<VM: MangaListViewModel>: View {
    @StateObject private var viewModel: VM
    @State var searchText: String = ""
    
    init(viewModel: VM) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 24) {
                    contentView
                }
                .padding(.horizontal, 16 )
            }
            .background(Color.whiteText)
            .task {
                if viewModel.filteredMangaDataBySection.isEmpty {
                    await viewModel.getData()
                }
            }
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer)
    }
    
    @ViewBuilder
    private var contentView: some View {
        switch viewModel.viewState {
        case .idle, .loading:
            LoadingView()
        case .success:
            successView
        case .error(let error):
            ErrorView(error: error) {
                Task {
                    await viewModel.getData()
                }
            }
        }
    }
    
    private var successView: some View {
        ForEach(viewModel.visibleSections, id: \.title) { section in
            MangaSectionView(
                sectionTitle: section.title,
                mangaData: viewModel.filteredMangaDataBySection[section] ?? [],
                mangaProtocol: viewModel
            )
        }
    }
}
