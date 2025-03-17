//
//  MainView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 17/12/23.
//

import SwiftUI

struct MainView: View {
    @State private var searchManga = ""
    @StateObject private var mangaViewModel = MangaListViewModel(service: MangaListService(network: Network()))

    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(MangaSortKey.allCases, id: \.self) { key in
                    MangaSectionView(sectionTitle: key.rawValue,
                                     mangaData: mangaViewModel.getSortedData(by: key))
                }
            }
        }
        .searchable(text: $searchManga)
        .environmentObject(mangaViewModel)
    }
}

