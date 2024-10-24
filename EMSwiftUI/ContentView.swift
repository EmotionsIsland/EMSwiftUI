//
//  ContentView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 17/12/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MainView(viewModel: MangaListViewModel(mangaService: MangaListService(network: Network())))
    }
}

