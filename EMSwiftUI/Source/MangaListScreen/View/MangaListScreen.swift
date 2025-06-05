//
//  MangaListScreen.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 17/12/23.
//

import SwiftUI

struct MangaListScreen<VM: MangaListViewModel>: View {
    @StateObject private var viewModel: VM
    @State private var searchText: String = ""

    init(viewModel: VM) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 24) {
                    Color(.grayBase)
                        .frame(height: 1)

                    switch viewModel.modelState {
                    case .loading:
                        makeShimmerView()
                    case .loaded(let models):
                        makeMangaList(with: models)
                    case .error:
                        Button("Reload") {}
                    }
                }
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer)
        }
    }
}

private extension MangaListScreen {
    func makeMangaList(with models: [MangaSection]) -> some View {
        ForEach(models) { section in
            if !section.models.isEmpty {
                MangaSectionView(sectionTitle: section.title, models: section.models)
            }
        }
    }

    func makeShimmerView() -> some View {
        ShimmerView(
            view:
                ForEach([
                    MangaSection.popular(models: MangaViewModel.makeMockModels()),
                    MangaSection.lastUpdates(models: MangaViewModel.makeMockModels()),
                    MangaSection.recentlyAdded(models: MangaViewModel.makeMockModels()),
                    MangaSection.seasonal(models: MangaViewModel.makeMockModels())
                ]) { section in
                    MangaSectionView(sectionTitle: section.title, models: section.models)
                }
        )
    }
}
