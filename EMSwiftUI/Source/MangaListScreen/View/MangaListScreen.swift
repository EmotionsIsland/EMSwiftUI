//
//  MangaListScreen.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 17/12/23.
//

import SwiftUI

struct MangaListScreen<VM: MangaListViewModel>: View {
    @StateObject private var viewModel: VM
    @Binding private var searchText: String
    
    init(viewModel: VM, searchText: Binding<String>) {
        _viewModel = StateObject(wrappedValue: viewModel)
        _searchText = searchText
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 40) {
                ForEach(filteredSections) { section in
                    MangaSectionView(title: section.title) {
                        ForEach(section.mangaList) { manga in
                            MangaSingleGridView(manga: manga)
                        }
                    }
                }
            }
            .padding(.vertical)
        }
        .task {
            await viewModel.getData()
        }
    }
    
    private var filteredSections: [MangaSection] {
        let trimmedQuery = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedQuery.isEmpty else {
            return viewModel.sections
        }
        
        return viewModel.sections.compactMap { section in
            let filteredManga = section.mangaList.filter { manga in
                manga.searchableTitle.localizedCaseInsensitiveContains(trimmedQuery)
            }

            guard !filteredManga.isEmpty else {
                return nil
            }

            return MangaSection(id: section.id, title: section.title, mangaList: filteredManga)
        }
    }
}

private extension MangaData {
    var searchableTitle: String {
        if let title = attributes.title.primary, !title.isEmpty {
            return title
        }
        
        return attributes.altTitles
            .compactMap(\.value)
            .first(where: { !$0.isEmpty }) ?? ""
    }
}
