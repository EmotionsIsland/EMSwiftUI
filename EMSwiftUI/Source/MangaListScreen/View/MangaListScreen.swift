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
                    content
                }
                .padding(.horizontal, 16 )
            }
            .background(Color.whiteText)
            .task {
                await viewModel.getData()
            }
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer)
    }
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.viewState {
        case .idle, .loading:
            loadingView
        case .success:
            successView
        case .error(let error):
            errorView(error)
        }
    }
    
    @ViewBuilder
    private var loadingView: some View {
        ProgressView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    @ViewBuilder
    private var successView: some View {
        ForEach(viewModel.visibleSections, id: \.title) { section in
            MangaSectionView(
                sectionTitle: section.title,
                mangaData: viewModel.filteredMangaDataBySection[section] ?? [],
                mangaProtocol: viewModel
            )
        }
    }
    
    @ViewBuilder
    private func errorView(_ error: String) -> some View {
        VStack(spacing: 12) {
            Text("Something went wrong:")
                .font(.headline)
            Text(error)
                .font(.subheadline)
            Button("Please try again!") {
                Task {
                    await viewModel.getData()
                }
            }
            .foregroundStyle(.blackBase)
            .padding()
            .background(Color.orangeBase)
            .cornerRadius(12)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
